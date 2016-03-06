class Blogo::ApplicationController < ::ApplicationController
  include Rails.application.routes.url_helpers

  def index
    @tag = params[:tag]

    @meta = {}
    @meta[:title]     = "#{Blogo.config.site_title} - #{Blogo.config.site_subtitle}"
    @meta[:site_name] = Blogo.config.site_title
    @meta[:keywords]  = Blogo.config.keywords
    @meta[:type]      = 'website'

    @tags = Blogo::Tag.all
  end
end
