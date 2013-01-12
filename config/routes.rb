HeiConnect::Application.routes.draw do
  api version: 1 do
    get 'user', :to => 'users#show', :as => :user
    get 'schedule', :to => 'schedules#show', :as => :schedule
    get 'sessions/grades', :to => 'sessions#grades', :as => :grades_sessions
    get 'sessions/absences', :to => 'sessions#absences', :as => :absences_sessions
    get 'grades', :to => 'grades#show', :as => :grades
    # get 'absences', :to => 'absences#show', :as => :absences
  end
  # root to: 'site#index'
end
