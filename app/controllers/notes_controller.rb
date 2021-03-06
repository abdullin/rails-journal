require 'chronic'

class NotesController < ApplicationController

  def new
    journal_id = params[:journal_id]
    @journal = Journal.find(params[:journal_id])
    @note = Note.new(journal_id: journal_id)
  end

  def create
    journal = Journal.find(params[:journal_id])
    note = journal.notes.create!(note_params)

    note.journal.touch
    redirect_to journal
  end

  def show
    @note = Note.find(params[:id])
  end


  def edit
    @note = Note.find(params[:id])
    @date_hint = @note.created_at
    @note.created_at = nil
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(note_params.reject{|_, v| v.blank?})
      @note.journal.touch
      redirect_to @note.journal
    else
      flash[:error] << @note.errors.full_messages
      render "edit"
    end
  end

  def destroy
    note = Note.find(params[:id])
    note.update(archived_at: DateTime.now.new_offset(0))
    redirect_to note.journal
  end

  private
  def note_params
    p = params.require(:note).permit(:content, :created_at)

    p[:created_at] = parse_time(p[:created_at])
    p
  end

  def parse_time(arg)
    return arg if arg.blank? or arg.starts_with?("202")
    Chronic.parse(arg)
  end
end
