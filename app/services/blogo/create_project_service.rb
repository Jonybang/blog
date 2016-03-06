module Blogo
  class CreateProjectService < CreatePostService
    attr_reader :post

    def initialize(user, params)
      @post        = user.projects.build
      @tags_string = params.delete(:tags_string)
      @post_attrs  = params
    end

    def create!
      super

    end
  end
end
