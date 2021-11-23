Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "urls#index"
  post '/urls/create' => "urls#create"
  get 'surl/:short_url_path' => "urls#redirect"
  get 'edit/:id' => "urls#edit"
  post 'edit/:id' => "urls#edit_url"
  get 'delete/:id' => "urls#delete"
end
