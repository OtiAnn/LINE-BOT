class LineUserController < ApplicationController
  def get_api
    params_from_line = params['result']
    if params_from_line.present?
      user_mid = params_from_line[0]['content']['from']
      line_user = LineUser.where(user_mid: user_mid).first_or_create!
      line_user_mid = line_user.user_mid
      send_sticker_to_user(user_mid: line_user_mid) if line_user_mid != 'uffffffffffffffffffffffffffffffff'

      head :ok, content_type: "text/html"
    else
      head :bad_request, content_type: "text/html"
    end
  end

  private

  # Line API
  # https://developers.line.me/bot-api/api-reference
  
  def send_sticker_to_user(user_mid: nil)
    send_content = {
      'to' => [user_mid],
      'toChannel' => 1383378250, #fixed
      'eventType' => '138311608800106203', #fixed
      'content' => {
        'contentType' => 8,
        'toType' => 1,
        'contentMetadata' => {
          'STKID' => ['144','156','164','172','177','501'].sample,
          'STKPKGID' => '2',
          'STKVER' => '100'
        }
      }
    }.to_json

    send_message_info(send_content: send_content)
  end

  def send_text_to_user(user_mid: nil)
    send_content = {
      'to' => [user_mid],
      'toChannel' => 1383378250, #fixed
      'eventType' => '138311608800106203', #fixed
      'content' => {
        'contentType' => 1,
        'toType' => 1,
        'text' => '哈囉你好啊～'
      }
    }.to_json

    send_message_info(send_content: send_content)
  end

  def send_message_info(send_content: nil)
    uri = URI.parse("https://trialbot-api.line.me/v1/events")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json; charset=UTF-8'})
    req.add_field('X-Line-ChannelID', ENV['X-Line-ChannelID'])
    req.add_field('X-Line-ChannelSecret', ENV['X-Line-ChannelSecret'])
    req.add_field('X-Line-Trusted-User-With-ACL', ENV['X-Line-Trusted-User-With-ACL'])
    req.body = send_content
    res = https.request(req)
  end
end
