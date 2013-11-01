require 'twitter'

class GetTweets

  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["YOUR_CONSUMER_KEY"]
      config.consumer_secret     = ENV["YOUR_CONSUMER_SECRET"]
      config.access_token        = ENV["YOUR_ACCESS_TOKEN"]
      config.access_token_secret = ENV["YOUR_ACCESS_SECRET"]
    end
  end

  def my_last_five_tweets
    tweets = client.user_timeline[0..4]
    tweets.each do |tweet|
      puts tweet.text
    end
  end

  def print_methods
    client.methods.each {|m| puts m}
    nil
  end

  def find_5_tweets_about(subject)
    tweets = client.search(subject, lang:'en').take(5)
    tweets.each do |tweet|
      puts tweet.text
      puts ''
    end
  end

  def find_5_geo_tweets_about(subject)
    tweets = client.search(subject, lang:'en').select(&:geo?).take(5)
    tweets.each do |tweet|
      puts tweet.geo
      puts ''
    end
  end
end
