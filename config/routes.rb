# frozen_string_literal: true

Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  root "pages#home"

  resources :lists, only: %i[show] do
    resources :tasks, only: %i[update destroy]
  end
end
