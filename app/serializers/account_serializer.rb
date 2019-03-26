class AccountSerializer < ActiveModel::Serializer
  attributes :id,
             :login,
             :user_id,
             :avatar_url,
             :bio,
             :public_repos,
             :public_gists,
             :followers,
             :following,
             :member_since,
             :state

  belongs_to :user
  has_many :events
end
