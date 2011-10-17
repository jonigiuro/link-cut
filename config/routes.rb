Tinyurl::Application.routes.draw do
  resources :projects

  devise_for :users

  resources :links
  match '/i/*full_path'  => 'links#hola'
  match '/o/*full_path'  => 'links#redir'
  #root :to  => 'links#home'
  root :to  => 'projects#index'
  match 'links/update'  => 'links#update'
end
