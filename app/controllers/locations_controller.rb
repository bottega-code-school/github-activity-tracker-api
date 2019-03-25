class LocationsController < ApplicationController
  include AuthenticationConcern

  def index
    if @current_user
      render json: @current_user.accounts.by_state
    else
      render json: { status: 401 }
    end
  end
end
