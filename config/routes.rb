# frozen_string_literal: true

Rails.application.routes.draw do
  get 'new', to: 'games#new', as: 'new'
  get 'score', to: 'games#score', as: 'score'
  post 'score', to: 'games#calc_score', as: 'calc_score'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
