# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# THE REAL SEED STARTS BELOW THIS LINE
#----------------------------------------
#
require 'date'

first_name = ["Eileen",
              "Joana",
              "Popov",
              "Dan",
              "Ana",
              "Louise",
              "Norma",
              "Jean",
              "Grey",
              "Jacques",
              "Elenor",
              "Julia",
              "Gabriel",
              "Alex"]
last_name = ["Popovich",
              "Moonster",
              "Hoshtkinson",
              "Hishiro",
              "Biggel",
              "Ranma",
              "Johnston",
              "Kingston",
              "King",
              "Garbo",
              "Stone",
              "Black",
              "Triane",
              "Dujardin",
              "Defunesse",
              "Coluche",
              "Bourdon",
              "Legitimus",
              "Lazos",
              "Bejo"]
first_word = ["This", "It", "That", "The"]
second_word = ["interviewer", "interview", "practice", "training", "session"]
third_word = ["was", "felt", "made me feel"]
fourth_word = ["great", "amazing", "awesome", "crappy", "competent", "prepared", "bad", "good"]
discipline =["Market Entry",
                  "M&A",
                  "New Product Development" ,
                  "Pricing",
                  "New Business",
                  "Competitive response",
                  "Increase Sales",
                  "Reduce Cost",
                  "Increase Profit",
                  "Turn-around"
                  ]
industry = ["Consumer Goods",
            "Airlines",
            "Energy (Oil & Gas / Mining)",
            "Financial Services (Insurance)",
            "Manufacturing",
            "Media",
            "Pharmaceuticals",
            "Private Equity",
            "Technology",
            "Telecom / Mobile",
            "Sports",
            "Other"]

Universities.get_all.each do |university|
  university = University.create! name: university.name, address: university.country
  puts "#{university.name} created"
end

50.times{
  @question = Question.new()
  @question.industry = industry.sample
  @question.discipline = discipline.sample
  @question.save!
  puts "added question #{@question.id} about #{@question.discipline} in #{@question.industry}"
}

120.times {
  @user = User.new()
  @user.first_name = first_name.sample
  @user.last_name = last_name.sample
  @user.password = "TestTEst"
  @user.email = "#{@user.first_name}.#{@user.last_name}#{rand(1..1000)}@gmail.com"
  @user.address = "#{rand(12..200)} rue de la #{first_name.sample}, #{last_name.sample}ville"
  @user.university_id = rand(10..50)
  @user.save!
  puts "Created #{@user.first_name} #{@user.last_name} who lives at #{@user.address} and who's email is #{@user.email}"
}
200.times{
  @meeting = Meeting.new()
  @meeting.interviewee_id = rand(1..100)
  @meeting.interviewer_id = @meeting.interviewee_id + rand(0..10)
  @meeting.finished = true
  @meeting.question_id = rand(10..90)
  @meeting.date = Date.current + rand(24..240)
  @meeting.save!
  puts "Created a meeting between #{@meeting.interviewee_id} user and #{@meeting.interviewer_id} on the #{@meeting.date} with question #{@meeting.question_id}"
      @review = Review.new()
      @review.rating = rand(1..5)
      @review.content = "#{first_word.sample} #{second_word.sample} #{third_word.sample} #{fourth_word.sample}"
      @review.user_id = @meeting.interviewee_id
      @review.meeting_id = @meeting.id
      @review.save!
      puts "Created a review for user id #{@review.user_id} with rating of #{@review.rating} and content #{@review.content}"

      @review = Review.new()
      @review.rating = rand(1..5)
      @review.content = "#{first_word.sample} #{second_word.sample} #{third_word.sample} #{fourth_word.sample}"
      @review.user_id = @meeting.interviewer_id
      @review.meeting_id = @meeting.id
      @review.save!
      puts "Created a review for user id #{@review.user_id} with rating of #{@review.rating} and content #{@review.content}"
}

