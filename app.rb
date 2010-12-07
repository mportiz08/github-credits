require 'sinatra'
require 'haml'

set :haml, :format => :html5

get '/' do
  @title = 'Github Credits'
  haml :index
end

get '/:author/:project' do
  @title = params[:project]
  @author = params[:author]
  @project = params[:project]
  @descr = "by #{params[:author]}"
  haml :project
end
