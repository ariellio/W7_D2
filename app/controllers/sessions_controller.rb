class SessionsController < ApplicationController
    def create
        @user = User.find_by_credentials(params[:user][:email],params[:user][:password])
        if @user.nil?
            flash.now[:errors] = @user.errors.full_messages 
            render :new
        else
            login!(@user)
            redirect_to user_url(@user)
        end
    end

    def destroy
        logout!
        flash[:success] = ['Successfully logged out']
        redirect_to new_session_url
    end

    
end