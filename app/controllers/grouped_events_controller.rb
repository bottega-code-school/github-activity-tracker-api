class GroupedEventsController < ApplicationController
  include AuthenticationConcern

  def index
    if @current_user
      if @current_user.accounts.any?
        account_ids = @current_user.accounts.pluck(:id)
        if Event.where(id: account_ids).any?
          events = Event.where(id: account_ids).group_by(&:created_at)
          puts "EVENT" * 500, events.inspect, "event" * 500
          render json: { events: events }
        else
          render json: { events: [] }
        end
      else
        render json: { events: [] }
      end
    else
      render json: { status: 401 }
    end
  end
end
