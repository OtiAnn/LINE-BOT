Rails.application.routes.draw do
  post 'callback' => 'line_user#get_api'
end
