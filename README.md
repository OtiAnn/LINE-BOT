##LINE BOT (for practice)


2016年春天 LINE 推出了[LINE BOT API](https://developers.line.me/bot-api/overview)

* [Line官方公告](https://business.line.me/news/20042497/detail)
* [申請Line Bot API Trial Account](https://business.line.me/services/products/4/introduction)
* [Line開發者文件](https://developers.line.me/bot-api/api-reference)


---

此專案為練習製作簡單的LINE BOT，以下是我的步驟：

Step 1. [申請Line Bot API Trial Account](https://business.line.me/services/products/4/introduction)，申請完帳號將得到帳號的`Channel ID`, `Channel Secret`, `MID`。

Step 2. 部署此專案到Heroku，將會得到專案網址：`xxxxxx.herokuapp.com`，再將callback URL填入[LINE Channel](https://developers.line.me/channels/)裡的`Callback URL` `https://xxxxxx.herokuapp.com:443/callback`。

Step 3. 在Heroku設定環境變數(Settings/Config Variables)：`X-Line-ChannelID`, `X-Line-ChannelSecret`, `X-Line-Trusted-User-With-ACL`，把Step 1的資訊填過來。

Step 4(option). 因為我用mysql，所以我必須把Heroku預設的postgres add-on刪掉，改成ClearDB MySQL :: Database add-on，另外要將Heroku環境變數中的`CLEARDB_DATABASE_URL`改成`DATABASE_URL`才會吃到資料庫。

---

提醒：

1. 很多教學文說Heroku要用Fixie add-on來固定專案IP，但實際使用後，發現IP還是會一直浮動出問題，所以我並未使用Fixie，也沒有設定LINE Channel中的White list還是可以用。

2. 使用者加LINE BOT帳號好友之後，要先發訊息給BOT，讓BOT先抓到使用者的mid，才能回傳訊息給該使用者，使用者的mid在很神奇的地方(`['result'][0]['content']['from']`)：

```
#以下是使用者傳 'Hello' 文字訊息給LINE BOT帳號時傳的params
{"result"=>
  [{
    "content"=>
    {
      "toType"=>1, #1: To user
      "createdTime"=>1468267793392,
      "from"=>"『這裡是使用者的mid』",
      "location"=>nil,
      "id"=>"4594064535777", #Identifier of the message.
      "to"=>["這裡是LINE BOT帳號的mid"],
      "text"=>"Hello",
      "contentMetadata"=>{"AT_RECV_MODE"=>"2", "SKIP_BADGE_COUNT"=>"true"},
      "deliveredTime"=>0,
      "contentType"=>1, #Text message
      "seq"=>nil
    },
    "createdTime"=>1468267793411,
    "eventType"=>"138311609000106303", #Received message
    "from"=>"u206d25c2ea6bd87c17655609a1c37cb8", #Fixed value
    "fromChannel"=>1341301815, #Fixed value
    "id"=>"WB1520-3611045150", #ID string to identify each event
    "to"=>["這裡是LINE BOT帳號的mid"],
    "toChannel"=>這裡是LINE BOT帳號的channel ID
  }]
 }
 ```
 
 * [更多LINE BOT API資訊](https://developers.line.me/bot-api/api-reference)
 