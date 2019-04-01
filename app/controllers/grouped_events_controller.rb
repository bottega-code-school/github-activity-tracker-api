class GroupedEventsController < ApplicationController
  include AuthenticationConcern

  def index
    if @current_user
      if @current_user.accounts.any?
        accounts = @current_user.accounts.pluck(:id, :login, :avatar_url)

        if Event.where(id: accounts[0]).any?
          populated_events = date_range.each_with_object([]).with_index do |(date, arr), idx|
            hash = Hash.new
            hash["bin"] = idx

            hash["bins"] = accounts.each_with_object([]) do |account, nested_arr|
              nested_hash = Hash.new
              nested_hash["bin"] = account[0]
              nested_hash["login"] = account[1]
              nested_hash["count"] = Event.where(account_id: account[0], date: date).length
              nested_hash["avatar_url"] = account[2]
              nested_arr << nested_hash
            end

            arr << hash
          end

          render json: { events: populated_events }
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

  private

    def date_range(a_range = 2.months.ago..0.days.ago)
      (a_range.begin.to_date..a_range.end.to_date).to_a
    end
end
