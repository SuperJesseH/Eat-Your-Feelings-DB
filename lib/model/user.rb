class User < ActiveRecord::Base
  has_many :reviews
  has_many :restaurants, through: :reviews

  extend EmoMod::ClassMethods
  include EmoMod::InstanceMethods
end
