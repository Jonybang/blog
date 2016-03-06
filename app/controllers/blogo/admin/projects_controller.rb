module Blogo::Admin
  # Responsible for posts management: creation, editing, deletion, preview.
  class ProjectsController < BaseController
    # GET /admin/posts
    #
    def index
      @projects = Blogo::Project.all
    end

    # GET /admin/posts/new
    #
    def new
      @project = Blogo::Project.new(published: true)
      @project.attachments.build
    end

    # POST /admin/posts
    #
    def create
      service = Blogo::CreateProjectService.new(blogo_current_user, project_params)

      if service.create!
        @project = service.post
        flash[:notice] = I18n.translate('blogo.admin.project_created')
        redirect_to blogo_admin_projects_path
      else
        @project = service.post
        render 'new'
      end
    end

    # GET /admin/posts/:id/edit
    #
    def edit
      @project = Blogo::Project.where(permalink: params[:id]).first!
    end

    # PATCH /admin/posts/:id
    #
    def update
      @project = Blogo::Project.where(permalink: params[:id]).first!
      service = Blogo::UpdateProjectService.new(@project, project_params)

      if service.update!
        flash[:notice] = I18n.translate('blogo.admin.project_updated')
        redirect_to blogo_admin_projects_path
      else
        render 'edit'
      end
    end

    # DELETE /admin/posts/:id
    #
    def destroy
      post = Blogo::Project.where(permalink: params[:id]).first!
      Blogo::DestroyPostService.new(post).destroy!

      flash[:notice] = I18n.translate('blogo.admin.project_removed')
      redirect_to blogo_admin_projects_path
    end

    # POST /admin/posts/preview
    #
    def preview
      @project         = Blogo::PreviewPostService.new(blogo_current_user, project_params).preview
      @meta         = {title: @project.title }
      @recent_posts = Blogo::Post.published.limit(Blogo.config.recent_posts) if Blogo.config.recent_posts
      @tags         = Blogo::Tag.all

      render 'blogo/posts/show', layout: 'blogo/blog'
    end


    private

    # Get post parameters from params.
    #
    # @return [Hash]
    def project_params
      params.require(:project).permit(:title, :permalink, :published_at, :raw_content, :published, :tags_string, attachments_attributes: [:id, :file, :_destroy])
    end
  end
end
