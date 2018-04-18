class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  #List all resturants/users by name
  def  self.all_names
    all.map {|restaurant| restaurant.name}
  end

end
