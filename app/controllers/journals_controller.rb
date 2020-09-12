class JournalsController < ApplicationController
  

  def show
    @journal = Journal.find(params[:id])
    @future_count = @journal.notes.future.count
    @notes = @journal.notes.visible.latest_first
  end

  def future
    @journal = Journal.find(params[:id])
    @notes = @journal.notes.future.chronologically
  end


  def edit
    @journal = Journal.find(params[:id])
  end


  def update
    journal = Journal.find(params[:id])
    journal.update_attributes(journal_params)
    redirect_to journal
  end

  def shelve
    journal = Journal.find(params[:id])
    journal.shelve
    flash.notice = "Journal shelved"
    redirect_to journal
  end


  private
  def journal_params
    params.require(:journal).permit(:content, :name, :category_id)
  end

end
