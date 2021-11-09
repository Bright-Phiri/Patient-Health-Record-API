module Api
    module V1 
        class UsersController < ApplicationController
            before_action :authorized, only: [:auto_login]

            def index
               render json: User.all.to_json(except: [:password_digest, :created_at, :updated_at])
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

            # LOGGING IN
            def login
                  begin
                     if User.exists?
                       @user = User.find_by_username!(params[:username]) #Getting dynamic finder to raise ActiveRecord::RecordNotFound exception
                       if @user && @user.authenticate(params[:password])
                         token = encode_token({user_id: @user.id})
                         render json: {status: 'success', message: 'Access granted', user: @user, token: token}, status: :ok
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
 
           def user_params
              params.permit(:username, :email,:password,:password_confirmation)
           end
        end
    end
end