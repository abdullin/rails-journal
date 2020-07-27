class ReviewController < ApplicationController
  def week
    
    @delta = params[:week].to_i || 0
    @date = Date.today + @delta.week
    @notes = Note.visible
      .where(:created_at => @date.beginning_of_week..@date.end_of_week)
      .reverse
  end

  def day
    @date = Date.today
    @notes = Note.visible
      .where(:created_at => @date.beginning_of_day..@date.end_of_day)
      .reverse
  end

  def future
    @notes = Note.future.reverse
  end

end
