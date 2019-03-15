class AccountSerializer < ActiveModel::Serializer
  attributes :id,
             :login

  belongs_to :user
end
