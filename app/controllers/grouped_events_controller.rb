class GroupedEventsController < ApplicationController
  include AuthenticationConcern

  def index
    if @current_user
      if @current_user.accounts.any?
        accounts = @current_user.accounts.pluck(:id, :login)

        if Event.where(id: accounts).any?
          events = Event.where(account_id: account_ids).group_by(&:account_id)
          date_range.each_with_object([]).with_index do |(date, arr), idx|
            hash = Hash.new
            hash["bin"] = idx

            hash["bins"] = accounts.each_with_object([]) do |account, nested_arr|
              nested_hash = Hash.new
              nested_hash["bin"] = acount[0]
              nested_hash["login"] = account[1]
              count = Event.where(id: account[0], date: date).length
            end

            arr << hash
          end
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
