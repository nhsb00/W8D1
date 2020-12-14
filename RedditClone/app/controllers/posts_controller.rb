class PostsController < ApplicationController
    class SubsController < ApplicationController

        before_action :ensure_author_id, only: [:edit, :update, :destroy]
    
        def new
            @post = Post.new
    
            render :new
        end
    
        def create
            @post = Post.new(post_params)
    
            if @sub.save
                redirect_to post_url(@post.id)
            else
                flash.now[:errors] = ['Details cannot be blank']
                render :new
            end
        end
    
        def edit
            @post ||= Post.find(params[:id])
    
            render :edit
        end
    
        def update
            @post ||= Post.find(params[:id])
    
            if @post.update(post_params)
                redirect_to post_url(@post.id)
            else
                flash[:errors] = ['Details cannot be blank']
                render :edit
            end
        end
    
        def show
            @post = Post.find(params[:id])
    
            render :show
        end
    
        def destroy
            @post ||= Post.find(params[:id])
    
            if @post && @post.destroy
                redirect_to post_url(@post.id)
            end
        end
    
        private
    
        def post_params
            params.require(:post).permit(
                :title, :content, :author_id, sub_ids: []
            )
        end
    
        def ensure_author_id
            @post = Post.find(params[:id])
            redirect_to post_url(@post.id) unless @post.author_id == current_user.id
        end
    
    end
    
end
