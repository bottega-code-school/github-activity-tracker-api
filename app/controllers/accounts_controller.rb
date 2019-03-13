class AccountsController < ApplicationController
  include AuthenticationConcern

  def index
    if @current_user
      render json: @current_user.accounts
    else
      render json: { status: 401 }
    end
  end

  def show
    # TODO
  end

  def create
    if @current_user
      account = Account.new(account_params)
      account.user_id = @current_user.id

      if account.save
        render json: account, status: :created
      else
        render json: account.errors, status: :unprocessable_entity
      end
    else
      render json: { status: 401 }
    end
  end

  def destroy
    # TODO
  end

  private

    def account_params
      params.require(:account).permit(:username)
    end
end
