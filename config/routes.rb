# frozen_string_literal: true

Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  root "pages#home"

  resources :todolists, only: %i[show]
  resources :todos, only: %i[show update destroy]
end
