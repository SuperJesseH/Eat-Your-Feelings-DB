require 'pry'
require 'paralleldots'
require 'net/http'
require 'json'
require_relative ("../keys.rb")

puts "REMEMBER TO PUT THE API KEYS BACK IN"
# Setting your API key
# paralleldots_key = "INSERT KEY"
# google_api_key = "INSERT KEY"
# UNCOMMENT PREVIOUS LINES TO SET YOUR API KEY

set_api_key(paralleldots_key)

places = ["ChIJQ_4N7hNawokRxOz5_NjiNoA", "ChIJFdlGXhFawokR7lPqXwaGirc", "ChIJEdxJIBRawokRK4AqcCIkKbA", "ChIJ8wQjtRlawokRPt5Bwv6cyZA", "ChIJBXCQjxBawokRrxEiP2Idp8U", "ChIJ15ymfBRawokRp-idXvp1rdY", "ChIJ7-ii9RNawokRB1W5aaO2O5k", "ChIJAWqtshZawokRpoLRfZ9B0y4", "ChIJST0cgRZawokRNvJv5mhG57E", "ChIJy5TRrRZawokR5mAVMKYBiFc", "ChIJUyCSBRRawokRxj-pVUcQK9U", "ChIJR39JUxZawokRHxxMOqZSBls", "ChIJ_QfhyiJawokR-LLcFIR-PIg", "ChIJr9lkOhFawokRaEaQXRNDVdc", "ChIJrxO2pRZawokRHcAcQimJyAI", "ChIJI5k7jBNawokRlAWRPuRMg1Q", "ChIJRWYXMBZawokRWzM00glz0yE", "ChIJD5fYOhRawokRDTetq4LAqBE", "ChIJe561bxZawokR7iWnSvqBJRE", "ChIJrc9T9fpYwokRAZcRVvva28s"]


def find_place_json(google_api_key, place_id)
  response = Net::HTTP.get_response(URI.parse("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=#{google_api_key}"))
  response = JSON.parse(response.body)
end

def sweet_emotion(text)
  emotion_results = emotion(text, lang_code= "en" )
  emotion_results["emotion"]
end

def build_places_hash(places, google_api_key, num_of_reviews_per = 4)
  places.map do |place|
    parsed = find_place_json(google_api_key, place)
    count = -1
    parsed["result"]["reviews"][1..num_of_reviews_per].map do |a|
      count += 1
      parsed["result"]["reviews"][count]["text"].gsub!(/[^0-9A-Za-z .!?$]/, '')
      {restaurant: parsed["result"]["name"], author: parsed["result"]["reviews"][count]["author_name"],
      review: parsed["result"]["reviews"][count]["text"], emotion_results: sweet_emotion(parsed["result"]["reviews"][count]["text"])}
    end
  end
end

review_results = build_places_hash(places, google_api_key, 4)
puts "I got the results!"

review_results.each do |val|
  val.each do |val2|
    u1 = User.where(name: val2[:author]).first_or_create
    puts "I made a user!"

    r1 = Restaurant.where(name: val2[:restaurant]).first_or_create
    puts "I made a restaurant!"

    rvw1 = Review.where(user: u1, restaurant: r1, content: val2[:review], angry: val2[:emotion_results]["probabilities"]["Angry"], sarcasm: val2[:emotion_results]["probabilities"]["Sarcasm"], happy: val2[:emotion_results]["probabilities"]["Happy"], excited: val2[:emotion_results]["probabilities"]["Excited"], sad: val2[:emotion_results]["probabilities"]["Sad"], bored: val2[:emotion_results]["probabilities"]["Bored"], fear: val2[:emotion_results]["probabilities"]["Fear"], emotion: val2[:emotion_results]["emotion"]).first_or_create
    puts "I made a review!"
  end
  puts "Hot dog! I did it."
end




# rvw1 = Review.create(user: review_results[0][0][:author], restaurant: review_results[0][0][:restaurant],content: review_results[0][0][:review], angry: review_results[0][0][:emotion_results]["probabilities"]["Angry"], sarcasm: review_results[0][0][:emotion_results]["probabilities"]["Sarcasm"], happy: review_results[0][0][:emotion_results]["probabilities"]["Happy"], excited: review_results[0][0][:emotion_results]["probabilities"]["Excited"], sad: review_results[0][0][:emotion_results]["probabilities"]["Sad"], bored: review_results[0][0][:emotion_results]["probabilities"]["Bored"], fear: review_results[0][0][:emotion_results]["probabilities"]["Fear"], emotion: review_results[0][0][:emotion_results]["emotion"])
# puts "Hot dog! I did it."
