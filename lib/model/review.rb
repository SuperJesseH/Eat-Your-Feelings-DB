class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  # BUILD OUT SOME REVIEw METHODS
  #NO AVERAGES INVOLVED

  @@emos = ["angry", "sarcasm", "happy", "excited", "sad", "bored", "fear"]
  @@break = "/////////////////////END OF RESULTS/////////////////////"

  def self.make_pretty_number(nasty_num)
    n = nasty_num.to_f
    (n*100).round(2)
  end

  def self.given_emotion(emo)
    all.each.with_index(1) do |review, index|
      if review.emotion.downcase == emo.downcase
        puts "Review ##{index}\nUsername: #{User.find(review.user_id).name} \nRestaurant: #{Restaurant.find(review.restaurant_id).name} \n\n#{review.content} \n -- Primary Emotion Detected: #{review.emotion.upcase}\nAngry: #{make_pretty_number(review.angry)}%, Sarcasm: #{make_pretty_number(review.sarcasm)}%, Happy: #{make_pretty_number(review.happy)}%, Excited: #{make_pretty_number(review.excited)}%, Sad: #{make_pretty_number(review.sad)}%, Bored: #{make_pretty_number(review.bored)}%, Fear: #{make_pretty_number(review.fear)}% \n\n\n"
      end
    end
    @@break
  end
end
