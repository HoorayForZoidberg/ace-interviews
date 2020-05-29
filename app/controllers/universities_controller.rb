class UniversitiesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @universities = University.all
    @universities = @universities.search(params[:search]) if params[:search].present?
    data = @universities.map do |university|
      {id: university.id, text: university.name}
    end
    render json: data
  end

end
