require 'sinatra'
require 'haml'
require 'lib/github'

module App
  include Github
  set :haml, :format => :html5

  get '/' do
    @title = 'Github Credits'
    haml :index
  end

  get '/:author/:project' do
    info = Project.info(params[:author], params[:project])
    @title = info["name"]
    @author = info["owner"]
    @project = info["name"]
    @descr = info["description"]
    haml :project
  end
end
