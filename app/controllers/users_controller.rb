class UsersController < ApplicationController
    before_action :authorize, only: [:show]

    def create
        user =  User.create!(user_params)
        if user
            session[:user_id] = user.id
            render json: user
        else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        render json: User.find_by(id: params[:session])
    end


    private

    def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
      end
    
      def user_params
        params.permit(:username, :password, :password_confirmation)
      end
    
end
