module Blogo
  # Responsible for showing posts and atom feeds to visitors.
  class ProjectsController < Blogo::ApplicationController
    layout 'blogo/blog'

    #resources_controller sti: true
    #Project = Blogo::Project
    #const_set 'Project', Blogo::Project

    extend RailsStuff::ResourcesController
    #extend RailsStuff::ResourcesController::ResourceHelper
    include RailsStuff::ResourcesController::BasicHelpers

    before_action :controller_vars
    before_action :get_collection, only: :index
    before_action :resource, only: :show

    before_action :index_meta, only: :index
    before_action :show_meta, only: :show



    protected
    def get_collection
      #@_collection = apply_scopes(resource_class).all
      @_collection = collection
    end

    def resource
      @_resource = Project.published.where(:permalink => params[:page]).first!
      @tags = @_resource.tags
    end

    def prepare_params
      if params[:cur_user]
        params[:user_id] = current_user.id
      end
    end
    def controller_vars
      self.class.resource_class = Blogo::Project.all
      @class_name = 'Project'
    end

    def index_meta
      @meta = {}
      @meta[:title]     = "#{Blogo.config.site_title} - #{Blogo.config.site_subtitle}"
      @meta[:site_name] = Blogo.config.site_title
      @meta[:keywords]  = Blogo.config.keywords
      @meta[:type]      = 'website'
    end

    def show_meta
      @meta = {}
      @meta[:title]       = "#{@_resource.title} - #{Blogo.config.site_title}"
      @meta[:description] = @_resource.meta_description
      @meta[:keywords]    = [@_resource.tags_string, Blogo.config.keywords].flatten.join(", ")
      @meta[:url]         = request.url
      @meta[:image]       = meta_image
      @meta[:type]        = 'article'
      @meta[:site_name]   = Blogo.config.site_title
    end

    def meta_image
      return nil unless @_resource.meta_image.present?

      if @_resource.meta_image =~ /\Ahttp/
        @_resource.meta_image
      else
        "#{request.protocol}#{request.host}#{@_resource.meta_image}"
      end
    end
  end
end
