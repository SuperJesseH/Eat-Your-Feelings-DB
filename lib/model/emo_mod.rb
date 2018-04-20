module EmoMod

    module ClassMethods
      @@emos = ["angry", "sarcasm", "happy", "excited", "sad", "bored", "fear"]
      @@break = "/////////////////////END OF RESULTS/////////////////////"
    #List all resturants/users by name
      def  all_names
        all.map {|inst| inst.name}
      end

      def sorted_by_given_emotion(emotion)
        a = all.sort_by {|inst| inst.emotions_dirty[emotion]}.reverse!
        a.each do |inst|
          puts "#{inst.name}: #{make_pretty_number(inst.emotions_dirty[emotion])}%"
        end
        @@break
      end

      def primary_emotion
        a = all.map do |inst|
          inst.emotions_sort.first << inst.name
        end
        a.each do |inst|
          puts "#{inst[2]} - #{inst[0].capitalize}: #{make_pretty_number(inst[1])}%"
        end
        puts
      end

      def make_pretty_number(nasty_num)
        n = nasty_num.to_f
        (n*100).round(2)
      end

    end

    module InstanceMethods
      @@emos = ["angry", "sarcasm", "happy", "excited", "sad", "bored", "fear"]
      @@break = "/////////////////////END OF RESULTS/////////////////////"

      def emotions_dirty
        #consider sorting by value make sure lables match values (see #emotions)
        new_hash = {}
        @@emos.each do |emotion|
          new_hash[emotion] = self.reviews.average(emotion.to_sym)
        end
        new_hash
      end

      def emotions_sort
        emotions_dirty.sort_by do |emotion, value|
          value
        end.reverse
      end

      def emotions
        emotions_sort.each do |emotion|
          puts "#{emotion[0].capitalize}: #{make_pretty_number(emotion[1].to_f)}%"
        end
        @@break
      end

      def emotion
        emotion = emotions_sort.first
        puts "#{emotion[0].capitalize}: #{make_pretty_number(emotion[1].to_f)}%"
        @@break
      end

      def make_pretty_number(nasty_num)
        n = nasty_num.to_f
        (n*100).round(2)
      end

      def pretty_reviews
        self.reviews.each.with_index(1) do |review, index|
          puts "Review ##{index}\nUsername: #{User.find(review.user_id).name} \nRestaurant: #{Restaurant.find(review.restaurant_id).name} \n\n#{review.content} \n -- Primary Emotion Detected: #{review.emotion.upcase}\nAngry: #{make_pretty_number(review.angry)}%, Sarcasm: #{make_pretty_number(review.sarcasm)}%, Happy: #{make_pretty_number(review.happy)}%, Excited: #{make_pretty_number(review.excited)}%, Sad: #{make_pretty_number(review.sad)}%, Bored: #{make_pretty_number(review.bored)}%, Fear: #{make_pretty_number(review.fear)}% \n\n\n"
        end
        @@break
      end

    end

end
