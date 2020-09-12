class PeopleController < ApplicationController
  def index
    @people = Person.all
      .order(updated_at: :desc)
  end

  def show
    @person = Person.find(params[:id])
  end
end
