class ReviewController < ApplicationController
  def week
    @categories = load_categories


    @delta = params[:week].to_i || 0
    @date = Date.today + @delta.week

    notes = Note.visible.within_week(@date)

    @category  = params.fetch(:category, -1).to_i
    notes = notes.with_category(@category) unless @category== -1
    @notes = notes.reverse
  end

  def day
    @date = Date.today
    @notes = Note.visible
      .where(:created_at => @date.beginning_of_day..@date.end_of_day)
  end

  def future
    @notes = Note.future.reverse
  end

  private 
  def load_categories
    cat = Category.all.sort_by { | cat | cat.name.downcase }
    cat << Category.new(name: "Other", id: 0)
    cat << Category.new(name: "All", id: -1)
    cat
  end
end
