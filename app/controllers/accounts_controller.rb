class AccountsController < ApplicationController
  include AuthenticationConcern
  include Github

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
    github_query = Github.username_search(params[:account][:login])
    github_account = JSON.parse(github_query.body)

    if github_account["login"]
      if @current_user
        account = Account.new(account_params)
        account.user_id = @current_user.id

        if account.save
          render json: github_account, status: :created
        else
          render json: account.errors, status: :unprocessable_entity
        end
      else
        render json: { status: 401 }
      end
    else
      render json: account.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # TODO
  end

  private

    def account_params
      params.require(:account).permit(:login)
    end
end
