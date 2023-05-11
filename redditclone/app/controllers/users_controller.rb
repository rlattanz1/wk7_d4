class UsersController < ApplicationController
    before_action :required_logged_in, only: [:update, :destroy]

    def edit
        @user = User.find_by(id: params[:id])
        render :edit
    end

    def update
        @user = User.find_by(id: params[:id])
        if @user.update(user_params)
            redirect_to users_url
        else
            flash.now[:errors] = @user.error.full_messages
            render :edit
        end
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to users_url
        else
            flash.now[:errors] = @user.error.full_messages
            render :new
        end
    end

    def destroy
        @user = User.find_by(id: params[:id])
        
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
