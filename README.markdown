A sinatra application that listens for an incoming
webhook from you public slack channels & posts gifs 
back to them.

Create an ingoing and outgoing webhook in your slack account.
You will also need to know the name of your slack sub domain &
where you have placed your gifs.

The directory structure should be

´´´
   ASSET_BASE_URL/TAG_NAME/NUMBER.gif
´´´

This will create a url that looks like

    http://box.tv4.se/slackr-gif-bot/hey-everybody-look-at-me/0.gif

To start it from the command line run it like this:

´´´
   SLACK_IN_TOKEN=YOUR_INCOMING_WEBHOOK_TOKEN SLACK_OUT_TOKEN=YOUR_OUTGOING_WEBHOOK_TOKEN SLACK_HOST=YOUR_SLACK_HOST ASSET_BASE_URL=YOUR_ASSET_BASE_URL rackup
´´´
