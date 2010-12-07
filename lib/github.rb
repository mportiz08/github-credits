require 'open-uri'
require 'json'

module Github
  ROOT_PATH = 'http://github.com/api/v2/json'
  
  class Project
    attr_reader :name, :owner, :description, :contributors
    
    def initialize(author, name)
      p_info = project_info(author, name)
      c_info = contributors_info(author, name)
      @name = p_info["name"]
      @owner = p_info["owner"]
      @description = p_info["description"]
      @contributors = []
      c_info.each do |user|
        @contributors << Contributor.new(user)
      end
    end
    
    def self.from(author, name)
      self.new(author, name)
    end
    
    private
    
    def path(user, repo)
      "#{ROOT_PATH}/repos/show/#{user}/#{repo}"
    end
    
    def project_info(user, repo)
      req = open(path(user, repo)).read
      resp = JSON.parse(req)["repository"]
    end
    
    def contributors_info(user, repo)
      req = open("#{path(user, repo)}/contributors").read
      resp = JSON.parse(req)["contributors"]
    end
  end
  
  class Contributor
    attr_reader :name, :avatar, :location, :url, :commits, :company
    
    def initialize(info)
      @name = info["name"] || info["login"] || ""
      @avatar = "http://www.gravatar.com/avatar/#{info["gravatar_id"]}?s=128" || ""
      @location = info["location"] || ""
      @url = info["blog"] || ""
      @commits = info["contributions"] || ""
      @company = info["company"] || ""
    end
  end
end
