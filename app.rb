require 'sinatra'
require 'haml'
require 'will_paginate'
require 'lib/github'

module App
  include Github
  set :haml, :format => :html5

  get '/' do
    @title = 'Github Credits'
    haml :index
  end

  get '/:author/:project' do
    page = params[:page] || "1"
    @project = Project.from(params[:author], params[:project])
    @contributors = @project.contributors.paginate({:page => page, :per_page => 10})
    @url = "#{request.path}?page=#{(page.to_i + 1).to_s}"
    @title = "#{@project.name} by #{@project.owner}"
    haml :project
  end
end
