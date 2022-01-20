module Api
    module V1 
        class UsersController < ApplicationController
            before_action :authorized, only: [:auto_login]
            before_action :set_user, only: [:show, :update, :destroy]

            def index
               render json: User.all.to_json(except: [:password_digest, :created_at, :updated_at])
            end

            def show
              render json: {status: 'success', message: 'User found', data: @user,avatar: url_for(@user.avatar)}
            end

            # REGISTER USER
            def create
               @user = User.create(user_params)
               if @user.valid?
                token = encode_token({user_id: @user.id})
                render json: {status: 'success', message: 'Account successfully created', user: @user, token: token}, status: :created
              else
                render json: {status:'error', message: 'Failed to create user account', error: @user.errors.full_messages}
              end
            end

            def update 
                @user.avatar.purge
                if @user.update(user_params)
                  render json: {status: 'success', message: 'user successfully updated', data: @user}, status: :ok
                else
                  render json: {status: 'error', message: 'failed to update user', errors: @user.errors.full_message}
                end
            end

            def destroy
              @user.avatar.purge
              if @user.destroy
                  render json: {status: 'success', message: 'user successfully deleted', data: @user}
              else
                  render json: {status: 'error', message: 'failed to deleted user'}
              end
            end

            # LOGGING IN
            def login
                  begin
                     if User.exists?
                       @user = User.find_by_username!(params[:username]) #Getting dynamic finder to raise exception
                       if @user && @user.authenticate(params[:password])
                         token = encode_token({user_id: @user.id})
                         render json: {status: 'success', message: 'Access granted', user: @user, token: token, avatar: url_for(@user.avatar)}, status: :ok
                       else
                         render json: {status: 'error', message: "Invalid username or password"}
                       end
                    else
                     render json: {status: 'error', message: "No user account found"}
                    end
                  rescue ActiveRecord::RecordNotFound
                     render json: {status: 'error', message: "Username not found"}
                  end
           end

           def auto_login
              render json: @user
           end

           private

           def set_user
             @user = User.find(params[:id])
           end
 
           def user_params
              params.permit(:username, :email, :avatar, :password,:password_confirmation)
           end
        end
    end
end