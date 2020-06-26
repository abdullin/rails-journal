class DaysController < ApplicationController
  def show
    @title = Date.today.strftime "%F"
    @day = DayNote.find_or_initialize_by(day: @title)
  end

  def update
    @day = DayNote.find_or_initialize_by(day: params[:id])
    @title = params[:id]
    if @day.update(day_params)
      flash.notice = "Saved"
      render 'show'
    end
  end


  private
  def day_params
    params.require(:day).permit(:content)
  end
end
