class NotesController < ApplicationController

  def new
    journal_id = params[:journal_id]
    @journal = Journal.find(params[:journal_id])
    @note = Note.new(journal_id: journal_id, created_at: Time.now)
  end

  def create
    journal = Journal.find(params[:journal_id])
    note = journal.notes.create!(note_params)
    note.journal.touch
    redirect_to journal
  end


  def edit
    @note = Note.find(params[:id])
  end

  def update
    note = Note.find(params[:id])
    note.update_attributes(note_params)
    note.journal.touch
    redirect_to note.journal
  end

  def destroy
    note = Note.find(params[:id])
    note.update(archived_at: DateTime.now.new_offset(0))
    redirect_to note.journal
  end

  private
  def note_params
    params.require(:note).permit(:content, :created_at)
  end
end
