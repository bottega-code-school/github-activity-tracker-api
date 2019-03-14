class AccountSerializer < ActiveModel::Serializer
  attributes :id,
             :username,
             :login

  belongs_to :user
end
