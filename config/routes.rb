Rails.application.routes.draw do
  
  get 'course_finder/find_courses'

  get 'searches/results'

  get 'results/show'

  resources :course_skills
  resources :prerequisites
  resources :users, only: :index
  root 'static_pages#home'
  
  get '/jobsearch/:query', to: 'static_pages#testing'
  get '/jobsearch', to: 'static_pages#testing'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#login'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'
  
  get '/account', to: 'users#account'
  post '/account', to: 'users#update'
  
  get '/account/edit', to: 'users#mod_user'
  
  get '/assessment', to: 'skill_assessments#skill_assessment'
  post '/assessment/results', to: 'skill_assessments#results', defaults: { format: 'js' }
  get '/assessment/results', to: 'skill_assessments#results'

  get '/courses/add', to: 'users#add_courses'
  post '/courses/add', to: 'users#save_courses'

  get '/jobs/match', to: 'skill_assessments#job_match'
  
  get '/searches/:id', to: 'searches#results'
  get '/searches/:id/ready', to: 'searches#ready'
  
  get '/courses/find', to: 'course_finder#find_courses'
  post '/courses/find', to: 'course_finder#course_results'
  get '/dashboard', to: 'dashboard#main'
  get '/dashboard/students', to: 'dashboard#students'
  get 'dashboard/myresults.csv', to:'dashboard#main'

  
  get '/about', to: 'static_pages#about'
  get '/faq', to: 'static_pages#faq'
  get '/contact', to: 'static_pages#contact'
  
  get '/dashboard/stats/users', to: 'dashboard#users_csv', :defaults => {:format => 'csv'}
  get '/dashboard/stats/user/:user_id', to: 'dashboard#user_csv', :defaults => {:format => 'csv'}
  get '/dashboard/stats/courses', to: 'dashboard#courses_csv', :defaults => {:format => 'csv'}
  
  get '/getskills', to: 'dashboard#skills_csv', :defaults => {:format => 'csv'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


