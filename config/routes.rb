HeiConnect::Application.routes.draw do
  api version: 1..2, module: 'V1' do
    get 'user', :to => 'users#show', :as => :user
    get 'schedule', :to => 'schedules#show', :as => :schedule
    get 'sessions/grades', :to => 'sessions#grades', :as => :grades_sessions
    get 'sessions/absences', :to => 'sessions#absences', :as => :absences_sessions
    get 'grades', :to => 'grades#show', :as => :grades
    get 'absences', :to => 'absences#show', :as => :absences
  end

  api version: 2, module: 'V2' do
    get 'grades_detailed', :to => 'grades#show_detailed', :as => :grades_detailed
  end
end
