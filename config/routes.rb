Rails.application.routes.draw do
  post 'callback' => 'get_api#line'
end
