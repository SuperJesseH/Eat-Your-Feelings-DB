class User < ActiveRecord::Base
  has_many :reviews
  has_many :restaurants, through: :reviews


  def self.all_names
    all.map {|user| user.name}
  end


  def emotions
    emos = ["angry", "sarcasm", "happy", "excited", "sad", "bored", "fear"]
    emos.map do |emotion|
      self.reviews.average(emotion.to_sym)
    end
  end






  # def emotions_by_review_ugly
  #   # emos = ["angry", "sarcasm", "happy", "excited", "sad", "bored", "fear"]
  #   self.reviews.map do |review|
  #     {angry: review.angry, sarcasm: review.sarcasm, happy: review.happy, excited: review.excited, sad: review.sad, bored: review.bored, fear: review.fear}
  #   end
  # end
  #
  # def emotions
  #   angry = 0
  #   sarcasm = 0
  #   emotions_by_review_ugly.map do |review|
  #     review.map do |emotion, emotion_value|
  #       emotion
  #     end
  #   end
  # end

end
