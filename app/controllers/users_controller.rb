class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :wrong_data
    wrap_parameters formart:[]
    protect_from_forgery with: :null_session
    def index
        users = User.all
        render json: users
    end
    def show 
        user = User.find_by(id: params[:id])
        render json: user
    end

    def create 
        user = User.create!(users_parameters)
        if user.valid?
            render json: user, status: :created
        else
            render user.errors.full_messages
        end
    end

    def update
        user = User.find_by(id: params[:id])
        if user
            user.update(users_parameters)
            render json: user, status: :accepted
        else 
            render json:{error:"user not found"}, status: :not_found
        end
    end

    def destroy
        user = User.find_by(id: params[:id])
        if user
            user.destroy
            head :no_content
        else 
            render json:{error:"user not found"}, status: :not_found
        end
    end

    private
    def users_parameters 
        params.permit(:name, :email)
    end

    def wrong_data(invalid)
        render json:{error: invalid.record.errors}, status: :unprocessable_entity
    end
end