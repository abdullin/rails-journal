class PeopleController < ApplicationController
  def index
    @people = Person.all
      .order(updated_at: :desc)
  end

  def show
    @person = Person.find(params[:id])
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(person_params.reject{|_, v| v.blank?})
      redirect_to @person
    else
      flash[:error] << @person.errors.full_messages
      render "edit"
    end
  end



  private
  def person_params
    params.require(:person).permit(:content)
  end
end
