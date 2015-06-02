require 'httparty'

module Commitchamp

  ACCESS_TOKEN = ENV['ACCESS_TOKEN']
  
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    def initialize
      @headers = { "Authorization" => "token #{ACCESS_TOKEN}",
                   "User-Agent" => "HTTParty"}
    end

    def get_user(username)
      self.class.get("/users/#{username}", headers: @headers)
    end

    def get_contributions(owner, repo, page=1)
      params = {
        page: page
      }
      options = {
        headers: @headers,
        query: params
      }
      self.class.get("/repos/#{owner}/#{repo}/stats/contributors", options)
    end
  end
end
