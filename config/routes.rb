Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "notifications#api_message"
  post "/send_notification", to: "notifications#send_notification"
  post "/create_user_action_notification", to: "notifications#create_user_action_notification"
  post "/create_web_scraping_notification", to: "notifications#create_web_scraping_notification"
  get "/get_all_notifications", to: "notifications#get_all_notifications"
  delete "/delete_all_notifications_related_to_user_task", to: "notifications#delete_all_notifications_related_to_user_task"
  delete "/delete_all_notifications_related_to_web_scraping_task", to: "notifications#delete_all_notifications_related_to_web_scraping_task"
end