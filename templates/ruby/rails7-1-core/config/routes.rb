# frozen_string_literal: true

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
# source: https://mattboldt.com/separate-rails-route-files/
Rails.application.routes.draw do
  # Devise Routes
  devise_for :users
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)

  # Starter Routes
  get "readme", to: "pages#readme"
  get "architecture", to: "pages#architecture"
  get "blog", to: "pages#blog"

  # API V1 Routes
  draw :api_v1

  root "pages#home"
end
