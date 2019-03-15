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
             :member_since

  belongs_to :user
end
