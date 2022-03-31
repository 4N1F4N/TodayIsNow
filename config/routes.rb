Rails.application.routes.draw do
  root 'pages#main', as: 'main'

  get '/:id', to: 'pages#main_pages'

  scope '/user' do
    get '/create', to: 'pages#user_create', as: 'user_create'
    post '/create', to: 'users#create'

    get '/login', to: 'pages#user_login', as: 'user_login'
    post '/login', to: 'users#login'

    post '/:id/delete', to: 'users#delete'

    get '/:id/edit', to: 'pages#user_edit', as: 'user_edit'
    post '/:id/edit', to: 'users#edit'

    post '/up_role', to: 'users#up_role'
    post '/down_role', to: 'users#down_role'

    post '/logout', to: 'users#logout'

    get '/:id', to: 'pages#user_show', as: 'user'
  end
  scope '/post' do
    get '/create', to: 'pages#post_create', as: 'post_create'
    post '/create', to: 'posts#create'

    get '/:id/edit', to: 'pages#post_edit', as: 'post_edit'
    post '/:id/edit', to: 'posts#edit'

    post '/delete', to: 'posts#delete'

    get '/closes', to: 'pages#post_closes'

    get '/:id', to: 'pages#post_show', as: 'post'
  end
end
