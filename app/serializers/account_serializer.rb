class AccountSerializer < ActiveModel::Serializer
  attributes :id,
             :username

  belongs_to :user
end
