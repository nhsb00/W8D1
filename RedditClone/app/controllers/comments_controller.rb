class CommentsController < ApplicationController

    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(comment_params)
    end

    def show
    end

    def comment_params
        params.require(:)
    end
end
