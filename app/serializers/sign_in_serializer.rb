class SignInSerializer < ActiveModel::Serializer
  attributes :email, :access_token
end
