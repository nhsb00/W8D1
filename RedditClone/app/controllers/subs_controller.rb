class SubsController < ApplicationController

    before_action :ensure_moderator, only: [:edit, :update, :destroy]

    def new
        @sub = Sub.new

        render :new
    end

    def create
        @sub = Sub.new(sub_params)

        if @sub.save
            redirect_to subs_url
        else
            flash.now[:errors] = ['Details cannot be blank']
            render :new
        end
    end

    def edit
        @sub ||= Sub.find(params[:id])

        render :edit
    end

    def update
        @sub ||= Sub.find(params[:id])

        if @sub.update(sub_params)
            redirect_to subs_url
        else
            flash[:errors] = ['Details cannot be blank']
            render :edit
        end
    end

    def index
        @sub = Sub.all
    
        render :index
    end

    def show
        @sub = Sub.find(params[:id])

        render :show
    end

    def destroy
        @sub ||= Sub.find(params[:id])

        if @sub && @sub.destroy

        end
    end

    private

    def sub_params
        params.require(:sub).permit(:title, :description, :moderator_id)
    end

    def ensure_moderator
        @sub = Sub.find(params[:id])
        redirect_to subs_url unless @sub.moderator_id == current_user.id
    end

end
