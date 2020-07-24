class ReviewController < ApplicationController
  def week
    today = Date.today
    @notes = Note.visible.where(:created_at => today.beginning_of_week..today.end_of_week)
  end

  def day
    today = Date.today
    @notes = Note.visible.where(:created_at => today.beginning_of_day..today.end_of_day)
    render "week"
  end

end
