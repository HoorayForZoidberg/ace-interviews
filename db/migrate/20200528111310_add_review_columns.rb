class AddReviewColumns < ActiveRecord::Migration[6.0]
  def change

    #general ratings
    add_column :reviews, :would_repeat, :boolean
    add_column :reviews, :polite_engaged, :integer

    #applicant ratings
    add_column :reviews, :structure, :integer
    add_column :reviews, :math, :integer
    add_column :reviews, :reasoning_originality, :integer
    add_column :reviews, :communication, :integer
    add_column :reviews, :confidence, :integer
    rename_column :reviews, :rating, :readiness

    #interviewer ratings
    add_column :reviews, :case_knowledge, :integer
    add_column :reviews, :case_presentation, :integer
    add_column :reviews, :accurate_feedback, :integer
    add_column :reviews, :constructive_criticism, :integer
    add_column :reviews, :level_adapted, :integer
    add_column :reviews, :full_attention, :integer
  end
end
