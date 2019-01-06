Rails.application.routes.draw do
  # This line mounts Solidus's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/'

  namespace :potepan do
    get '/',                        to: 'homes#index'
    get 'index',                    to: 'homes#index'
    get '/search',                  to: 'products#search'
    get '/cart',                    to: 'orders#edit'
    get :product_grid_left_sidebar, to: 'sample#product_grid_left_sidebar'
    get :product_list_left_sidebar, to: 'sample#product_list_left_sidebar'
    get :single_product,            to: 'sample#single_product'
    get :cart_page,                 to: 'sample#cart_page'
    get :checkout_step_1,           to: 'sample#checkout_step_1'
    get :checkout_step_2,           to: 'sample#checkout_step_2'
    get :checkout_step_3,           to: 'sample#checkout_step_3'
    get :checkout_complete,         to: 'sample#checkout_complete'
    get :blog_left_sidebar,         to: 'sample#blog_left_sidebar'
    get :blog_right_sidebar,        to: 'sample#blog_right_sidebar'
    get :blog_single_left_sidebar,  to: 'sample#blog_single_left_sidebar'
    get :blog_single_right_sidebar, to: 'sample#blog_single_right_sidebar'
    get :about_us,                  to: 'static_pages#about'
    get :tokushoho,                 to: 'sample#tokushoho'
    get :privacy_policy,            to: 'sample#privacy_policy'
    post '/add_cart',               to: 'orders#add_cart'
    patch '/cart',                  to: 'orders#update'

    resources :products, only: [:show, :index]
    resources :categories, only: [:show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
