module Blogo
  class UpdateProjectService < UpdatePostService
    attr_reader :post

    def initialize(post, params)
      @post        = post
      @tags_string = params.delete(:tags_string)
      @post_attrs  = params
    end

    def update!
      super
    end
  end
end
