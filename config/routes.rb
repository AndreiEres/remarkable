# frozen_string_literal: true

Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  root "pages#home"

  resources :lists, only: [:show] do
    resources :tasks, only: [:destroy]
  end
end
