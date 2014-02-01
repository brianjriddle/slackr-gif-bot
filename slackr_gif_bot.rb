require 'net/http'
#require 'net/https'
require 'sinatra'
require 'json'
require "sinatra/reloader" if development?
require './tags'
require 'uri'

SLACK_IN_TOKEN  = ENV["SLACK_IN_TOKEN"]
SLACK_OUT_TOKEN = ENV["SLACK_OUT_TOKEN"]
SLACK_HOST = ENV["SLACK_HOST"]
ASSET_BASE_URL  = ENV["ASSET_BASE_URL"] || "/gif"

def find_text(s)
  text = "Fungerade nyckel ord för gif är " + TAGS.keys.join(",")
  if match = s.match(/gif:(\w+)/i)
    tag = match.captures[0]
    if TAGS.has_key? tag
      text =  ASSET_BASE_URL + "/#{tag}/#{TAGS[tag].to_a.sample}.gif"
    end
  end
  return text
end

post '/' do
  channel_name =  params[:channel_name] || "giiiiiifs"
  text = find_text params[:text]
  if SLACK_IN_TOKEN.eql?(params[:token])
    data = {:channel_name => channel_name, :username => "GifBot", :icon_emoji => ":punch:", :text => text}
    headers = {"Content-Type" => "application/json", "Content-Length" => data.length.to_s }
    http = Net::HTTP.new(SLACK_HOST, 443)
    http.use_ssl = true  
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.post("/services/hooks/incoming-webhook?token=#{SLACK_OUT_TOKEN}", data.to_json, headers)
    puts response.body
  else
    puts "Token mismatch"
  end 
end
