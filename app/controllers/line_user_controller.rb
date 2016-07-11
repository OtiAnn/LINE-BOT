class LineUserController < ApplicationController
  def get_api
    params_from_line = params['result']
    if params_from_line.present?
      user_mid = params_from_line[0]['content']['from']
      LineUser.first_or_create!(user_mid: user_mid)
      render status: 200
    else
      render status: 400
    end
  end
end
