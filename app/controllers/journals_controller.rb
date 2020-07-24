class JournalsController < ApplicationController
  def index
    @journals = Journal.all
  end

  def show
    @journal = Journal.find(params[:id])
    @future_count = @journal.notes.future.count
    @notes = @journal.notes.visible.order(created_at: :desc)
  end


  def edit
    @journal = Journal.find(params[:id])
  end


  def update
    journal = Journal.find(params[:id])
    journal.update_attributes(journal_params)
    redirect_to journal
  end


  private
  def journal_params
    params.require(:journal).permit(:content, :name)
  end
end
