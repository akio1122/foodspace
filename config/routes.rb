Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  # Activeadmin
  ActiveAdmin.routes(self)
  devise_for :users, ActiveAdmin::Devise.config
  
  # Activeadmin helpers
  mount_activeadmin_settings()
  
  # Images
  get 'thumb/:id/:width/:height' => 'thumb#thumb'

  ## index
  root 'frontend/home#index'

  ## contact
    match '/contact',    to: 'frontend/contact#new', via: 'get'
    resources "contact", as: "contacts", controller: 'frontend/contact',  only: [:new, :create]
  
  ## search
    get 'search' => 'frontend/search#results'

  ## story
    # story > stories
    # story > story
    get 'story/:id' => 'frontend/story#single'
    get 'stories'   => 'frontend/story#list'

  ## vendor
    # vendor > vendors
    # vendor > vendor
    match '/vendor/:id/contact', to: 'frontend/contact#new', via: 'get', defaults: { type: 'vendor_contact' }
    resources "vendor/:id/contact", as: "contacts", controller: 'frontend/contact',  only: [:new, :create]
    get 'vendor/:id' => 'frontend/vendor#single'
    get 'vendors'    => 'frontend/vendor#list'

  ## event
    # event > events
    # event > post
    get 'event/:id'    => 'frontend/event#single'
    get 'events'       => 'frontend/event#list'
    get 'events/:date' => 'frontend/event#list'

  ## pages
    # page > about
    get 'about'   => 'frontend/page#single', defaults: { id: 'about' }

    # page > generic
    get 'page/:id' => 'frontend/page#single'
  ## Errors
    # 404
    match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]

end
