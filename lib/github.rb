require 'open-uri'
require 'json'

module Github
  ROOT_PATH = 'http://github.com/api/v2/json'
  
  class Project
    def self.info(user, repo)
      req = open("#{ROOT_PATH}/repos/show/#{user}/#{repo}").read
      resp = JSON.parse(req)["repository"]
    end
  end
end
