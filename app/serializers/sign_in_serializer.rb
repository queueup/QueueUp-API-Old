# frozen_string_literal: true

class SignInSerializer < ActiveModel::Serializer
  attributes :email, :access_token
end
