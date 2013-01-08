module Konosys
  module Actions
    class Schedule < Konosys::Action

      class WeekEntity < APISmith::Smash
        # Week's number in the year, eg: 23
        property :number, :transformer => :to_i
        # CourseEntity collection
        property :courses
      end

      class CourseEntity < APISmith::Smash
        # Course's id, eg: 149264
        property :id, :transformer => :to_i
        # Datetime with timezone (ActiveSupport::TimeZone)
        property :date
        # Course's length in minutes, eg: 90
        property :length, :transformer => :to_i
        # Course's type, eg: Cours
        property :type, :transformer => lambda { |t| t.strip }
        # Course's group, eg: 4ITI
        property :group, :transformer => lambda { |t| t.strip }
        # Course's code, eg: ITI038
        property :code, :transformer => lambda { |t| t.strip }
        # Course's name, eg: Ergonomie des IHM
        property :name, :transformer => lambda { |t| t.strip }
        # Course's room, eg: ET50
        property :room, :transformer => lambda { |t| t.strip }
        # Course's TeacherEntity collection
        property :teachers
      end

      class TeacherEntity < APISmith::Smash
        # Teacher's name, eg: LAST-NAME First-name
        property :name, :transformer => lambda { |t| t.strip }
      end

      SCHEDULE_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/MonPlanning_Utilisateur_Lot.aspx'

      def fetch
        login

        @browser.goto(SCHEDULE_URL)
        current_week_source = @browser.xml.force_encoding('utf-8')
        @browser.button(:id, 'semsuiv').click
        next_week_source = @browser.xml.force_encoding('utf-8')

        weeks = Array.new
        weeks.push parse_week(current_week_source)
        weeks.push parse_week(next_week_source)

        weeks
      end

      private

      def parse_week(data)
        # Fetch date from hidden form input
        date_components = data.scan(/name="_DateDebutSemaine_hidden" type="text" value="(\d+)\/(\d+)\/(\d+)"/)
        date = Date.new(*date_components.flatten.reverse.collect { |i| i.to_i })
        number = date.cweek

        # Fetch courses
        courses = Array.new
        raw_courses = data.scan(/AjouterRDV\((\d+),(\d+),(\d+),(\d+),'((?:(?<=\\)[']|[^'])*)',.*'(\d{2,})',/i)
        raw_courses.each do |raw_course|
          courses.push parse_course(raw_course, date)
        end

        WeekEntity.new number: number, courses: courses
      end

      def parse_course(data, first_day_of_week)
        day, hour, minute = data[0..2]
        course_day = first_day_of_week + day.to_i - 1
        date = ActiveSupport::TimeZone['Paris'].parse("#{course_day.year}/#{course_day.month}/#{course_day.day}" +
                                                          " #{hour.to_i}h#{minute.to_i}")
        length, id = data[3], data[5]

        course = CourseEntity.new date: date, length: length, id: id

        data = data[4].gsub(/#{Regexp.escape('\\')}/, '').split('<br>')
        if data.count >= 4
          sub_data = data[0].split('-')
          course.code = sub_data[0][0..-2]
          course.name = sub_data[1][1..-1]
          course.room = data[1][6..-1]
          course.group = data[2][7..-2]
          course.type = data[3]
          course.teachers = parse_teachers(data[4]) if data.count == 5
        else
          course.name = data.join ' '
        end

        course
      end

      def parse_teachers(data)
        teachers = Array.new
        data.split(',').each do |raw_teacher|
          teachers.push TeacherEntity.new name: raw_teacher
        end
      end
    end
  end
end