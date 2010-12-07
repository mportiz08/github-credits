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
    @project = Project.from(params[:author], params[:project])
    @contributors = @project.contributors
    @title = "#{@project.name} by #{@project.owner}"
    haml :project
  end
end
