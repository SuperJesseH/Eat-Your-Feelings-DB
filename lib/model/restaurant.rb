class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  @@emos = ["angry", "sarcasm", "happy", "excited", "sad", "bored", "fear"]

  #List all resturants/users by name
  def  self.all_names
    all.map {|restaurant| restaurant.name}
  end

  def emotions_dirty
    @@emos.map do |emotion|
      self.reviews.average(emotion.to_sym)
    end
  end

  def emotions
    emotions_dirty.each_with_index do |emotion, index|
      value = emotion.to_f.round(2)
      value = value*100
      puts "#{@@emos[index].capitalize}: #{value}%"
    end
    ""
  end

end
