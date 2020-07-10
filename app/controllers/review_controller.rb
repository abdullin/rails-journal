class ReviewController < ApplicationController
  def week
    today = Date.today

    @notes = Note.where(:created_at => today.beginning_of_week..today.end_of_week)

  end

end
