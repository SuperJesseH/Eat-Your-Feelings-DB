class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  @@emos = ["angry", "sarcasm", "happy", "excited", "sad", "bored", "fear"]
  @@break = "/////////////////////BREAK/////////////////////"

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
      value = emotion.to_f
      value = (value*100).round(2)
      puts "#{@@emos[index].capitalize}: #{value}%"
    end
    @@break
  end

end
