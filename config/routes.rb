Tinyurl::Application.routes.draw do
  devise_for :users

  resources :links
  match '/i/*full_path'  => 'links#hola'
  match '/o/*full_path'  => 'links#redir'
  root :to  => 'links#home'

end
