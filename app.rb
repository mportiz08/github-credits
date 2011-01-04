require 'rubygems'
require 'bundler/setup'
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
  
  get '/search' do
    query = params[:q].split('/')
    author, project = query[0], query[1]
    redirect "/#{author}/#{project}"
  end
  
  get '/about' do
    redirect 'mportiz08/github-credits'
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
