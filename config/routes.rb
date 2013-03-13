HeiConnect::Application.routes.draw do

  api version: 1, module: 'V1' do
    get 'absences', :to => 'absences#show', :as => :v1_absences
    get 'grades', :to => 'grades#show', :as => :v1_grades
    get 'schedule', :to => 'schedules#show', :as => :v1_schedule
    get 'sessions/absences', :to => 'sessions#absences', :as => :v1_absences_sessions
    get 'sessions/grades', :to => 'sessions#grades', :as => :v1_grades_sessions
    get 'user', :to => 'users#show', :as => :v1_user
  end

  api version: 2, module: 'V2' do
    get 'absences', :to => 'absences#show', :as => :v2_absences
    get 'grades', :to => 'grades#show', :as => :v2_grades
    get 'grades_detailed', :to => 'grades#show_detailed', :as => :v2_grades_detailed
    get 'schedule', :to => 'schedules#show', :as => :v2_schedule
    get 'sessions/absences', :to => 'sessions#absences', :as => :v2_absences_sessions
    get 'sessions/grades', :to => 'sessions#grades', :as => :v2_grades_sessions
    post 'users', :to => 'users#create', :as => :v2_users
    get 'users', :to => 'users#show'
  end
end
