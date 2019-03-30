class GroupedEventsController < ApplicationController
  include AuthenticationConcern

  def index
    if @current_user
      if @current_user.accounts.any?
        account_ids = @current_user.accounts.pluck(:id)
        if Event.where(id: account_ids).any?
          events = Event.where(account_id: account_ids).group_by(&:account_id)
          events_grouped_by_date = account_ids.map do |account_id| 
            events[account_id].group_by(&:date)
          end
          render json: { events: events_grouped_by_date }
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
