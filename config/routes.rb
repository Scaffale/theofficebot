Rails.application.routes.draw do
  unless Rails.env.test?
	  telegram_webhook TelegramWebhooksController
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
