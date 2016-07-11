class LineUserController < ApplicationController
  def get_api
    params_from_line = params['result']
    if params_from_line.present?
      user_mid = params_from_line[0]['content']['from']
      LineUser.first_or_create!(user_mid: user_mid)
      head :ok, content_type: "text/html"
    else
      head :bad_request, content_type: "text/html"
    end
  end
end
