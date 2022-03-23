Rails.application.routes.draw do
  root 'pages#main'

  get '/:id', to: 'pages#main_pages'

  scope '/user' do
    get '/create', to: 'pages#user_create'
    post '/create', to: 'users#create'

    get '/login', to: 'pages#user_login'
    post '/login', to: 'users#login'

    #get '/change', to: 'pages#change'
    #post '/change', to: 'users#change'

    post '/up_role', to: 'users#up_role'
    post '/down_role', to: 'users#down_role'

    post '/logout', to: 'users#logout'

    get '/:id', to: 'pages#user_show', as: 'user'
  end
  scope '/post' do
    post '/create', to: 'posts#create'

    get '/:id', to: 'pages#post_show', as: 'post'
  end
end
