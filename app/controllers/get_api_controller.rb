class GetApiController < ApplicationController
  def line
    permitted = params.permit('result' => { 'content' => 'from' })
    if permitted.permitted?
      user_mid = permitted['result'][0]['content']['from']
      LineUser.first_or_create!(user_mid: user_mid)
      render status: 200
    else
      render status: 400
    end
  end
end
