class User < ActiveRecord::Base
  has_many :reviews
  has_many :restaurants, through: :reviews

  @@emos = ["angry", "sarcasm", "happy", "excited", "sad", "bored", "fear"]
  @@break = "/////////////////////END OF RESULTS/////////////////////"

  #List all resturants/users by name
  def  self.all_names
    all.map {|user| user.name}
  end

  def self.happy_list
    a = all.sort_by {|user| user.emotions_dirty[2]}.reverse!
    a.each do |user|
      puts "#{user.name}: #{make_pretty_number(user.emotions_dirty[2])}%"
    end
    @@break
  end

  def emotions_dirty
    #consider sorting by value make sure lables match values (see #emotions)
    @@emos.map do |emotion|
      self.reviews.average(emotion.to_sym)
    end
  end

  def emotions
    emotions_dirty.each_with_index do |emotion, index|
      puts "#{@@emos[index].capitalize}: #{make_pretty_number(emotion.to_f)}%"
    end
    @@break
  end

  def self.make_pretty_number(nasty_num)
    n = nasty_num.to_f
    (n*100).round(2)
  end

  def make_pretty_number(nasty_num)
    n = nasty_num.to_f
    (n*100).round(2)
  end

end
