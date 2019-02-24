Rails.application.routes.draw do
  if Rails.env.production?
	  telegram_webhook TelegramWebhooksController
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
