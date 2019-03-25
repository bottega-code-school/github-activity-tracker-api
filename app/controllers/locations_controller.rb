class LocationsController < ApplicationController
  include AuthenticationConcern

  def index
    if @current_user
      if @current_user.accounts.any?
        render json: @current_user.accounts.group_by(&:state)
      else
        render json: @current_user.accounts
      end
    else
      render json: { status: 401 }
    end
  end
end
