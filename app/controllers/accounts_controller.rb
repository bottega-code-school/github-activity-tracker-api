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
    # TODO
  end

  def destroy
    # TODO
  end
end
