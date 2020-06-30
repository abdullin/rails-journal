class NotesController < ApplicationController
  def show
  end

  def create
    journal = Journal.find(params[:journal_id])
    note = journal.notes.create!(params.require(:note).permit(:content))
    redirect_to journal
  end

  def new
    @journal_id = params[:journal_id]
    @journal = Journal.find(params[:journal_id])
    @note = Note.new(journal_id: @journal_id)
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    note = Note.find(params[:id])
    note.update_attributes(note_params)
    redirect_to note.journal

  end

  private
  def note_params
    params.require(:note).permit(:content)
  end
end
