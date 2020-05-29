# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# THE REAL SEED STARTS BELOW THIS LINE
#----------------------------------------
if Rails.env.development?
  Review.destroy_all
  Meeting.destroy_all
  User.destroy_all
  University.destroy_all
  Question.destroy_all
end

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
# university_one = ["Ireland", "France", "UK", "'Merica", "Colombia", "China", "Chonkers"]
# university_two = ["School", "University", "College", "Educatorium"]
# university_three = ["of Tech", "of Business", "of Economics", "of Arts", "of Paleontology", "of Arts", "of Sports", "of Imagination", "of Philosophy"]

Universities.get_all.first(100).each do |university|
  university = University.create! name: university.name, address: university.country
  puts "#{university.name} created"
end

# --- ALREADY SUCCESSFULLY RAN ---
# 50.times do
#   @university = University.new()
#   @university.name = "#{university_one.sample} #{university_two.sample} #{university_three.sample}"
#   @university.address = "#{university_one}"
#   @university.save
#   puts "added #{@university.name} from #{@university.address}"
# end

50.times{
  @question = Question.new()
  @question.industry = industry.sample
  @question.discipline = discipline.sample
  @question.save!
  puts "added question #{@question.id} about #{@question.discipline} in #{@question.industry}"
}

100.times {
  @user = User.new()
  @user.first_name = first_name.sample
  @user.last_name = last_name.sample
  @user.password = "TestTest"
  @user.email = "#{@user.first_name}.#{@user.last_name}#{rand(1..1000)}@gmail.com"
  @user.address = "#{rand(12..200)} rue de la #{first_name.sample}, #{last_name.sample}ville"
  @user.university = University.all.sample
  @user.save!
  puts "Created #{@user.first_name} #{@user.last_name} who lives at #{@user.address} and who's email is #{@user.email}"
}
100.times{
  @meeting = Meeting.new()
  @meeting.interviewee = User.all.sample
  @meeting.interviewer = (User.all - [@meeting.interviewee]).sample
  @meeting.finished = true
  @meeting.question = Question.all.sample
  @meeting.date = DateTime.current + rand(24..240).hours
  @meeting.save!
  puts "Created a meeting between #{@meeting.interviewee_id} user and #{@meeting.interviewer_id} on the #{@meeting.date} with question #{@meeting.question_id}"

      @review = Review.new()
      current_user = @meeting.interviewee
      @review.user_id = @meeting.interviewee_id
      @review.meeting_id = @meeting.id

      @review.would_repeat = true
      @review.polite_engaged = rand(1..5)

      @review.structure = rand(1..5)
      @review.math = rand(1..5)
      @review.reasoning_originality = rand(1..5)
      @review.communication = rand(1..5)
      @review.confidence = rand(1..5)
      @review.readiness = rand(1..5)

      @review.content = "#{first_word.sample} #{second_word.sample} #{third_word.sample} #{fourth_word.sample}"

      @review.save!
      puts "Created a review for interviewer #{@review.user_id}"

      @review = Review.new()
      current_user = @meeting.interviewer
      @review.user_id = @meeting.interviewer_id
      @review.meeting_id = @meeting.id

      @review.would_repeat = true
      @review.polite_engaged = rand(1..5)

      @review.case_knowledge = rand(1..5)
      @review.case_presentation = rand(1..5)
      @review.accurate_feedback = rand(1..5)
      @review.constructive_criticism = rand(1..5)
      @review.level_adapted = rand(1..5)
      @review.full_attention = rand(1..5)

      @review.content = "#{first_word.sample} #{second_word.sample} #{third_word.sample} #{fourth_word.sample}"

      @review.save!
      puts "Created a review for interviewee #{@review.user_id}"
}

