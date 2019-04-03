namespace :github_data_updater do
  desc "Iterates over account data and updates events"
  task run: :environment do
    include Github

    Account.where(login: 'jordanhudgens').each do |account|
      event_ids = account.events.pluck(:id)
      event_query = Github.fetch_events(account.login)

      JSON.parse(event_query.body).each do |event|
        if event["type"] == "PushEvent" && !event_ids.include?(event["id"])
          Event.create!(
            account: account,
            github_event_id: event["id"],
            repo_name: event["repo"]["name"],
            repo_url:  event["repo"]["url"],
            date: event["created_at"].to_date,
            message: event["payload"]["commits"][0]["message"],
            commit_count: event["payload"]["size"],
            username: account.login
          )
        end
      end
    end
  end
end
