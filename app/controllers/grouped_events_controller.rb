class GroupedEventsController < ApplicationController
  include AuthenticationConcern

  def index
    if @current_user
      if @current_user.accounts.any?
        account_ids = @current_user.accounts.pluck(:id)
        if Event.where(id: account_ids).any?
          events = Event.where(account_id: account_ids).group_by(&:account_id)

          account_hash = account_ids.each_with_object({}) do |account_id, hash|
            hash[account_id] = []
          end

          account_ids.each do |account_id|
            if events[account_id]
              account_hash[account_id] = events[account_id].group_by(&:date)
            end
          end

          render json: { events: account_hash }
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
