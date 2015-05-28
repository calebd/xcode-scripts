require 'rest-client'

def message
  ENV['CMD_SLACK_MESSAGE']
end

def icon
  ENV['CMD_SLACK_ICON']
end

def url
  ENV['CMD_SLACK_URL']
end

def send_message
  parameters = {
    text: message,
    icon_emoji: icon
  }.to_json
  RestClient.post(url, parameters)
end

raise 'Unable to send Slack message.' unless send_message
