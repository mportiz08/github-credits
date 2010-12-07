require 'open-uri'
require 'json'

module Github
  ROOT_PATH = 'http://github.com/api/v2/json'
  
  class Project
    attr_reader :name, :owner, :description
    
    def initialize(author, name)
      information = info(author, name)
      @name = information["name"]
      @owner = information["owner"]
      @description = information["description"]
    end
    
    def self.from(author, name)
      self.new(author, name)
    end
    
    private
    
    def path(user, repo)
      "#{ROOT_PATH}/repos/show/#{user}/#{repo}"
    end
    
    def info(user, repo)
      req = open(path(user, repo)).read
      resp = JSON.parse(req)["repository"]
    end
  end
end
