class ReviewController < ApplicationController
  def week
    @categories = load_categories

    @delta = params[:week].to_i || 0
    @date = Date.today + @delta.week

    notes = Note.not_archived.within_week(@date)

    @category  = params.fetch(:category, -1).to_i
    notes = notes.with_category(@category) unless @category== -1
    @notes = notes.chronologically
  end

  def day
    @date = Date.today
    @notes = Note.visible.within_day(@date).chronologically
  end

  private 
  def load_categories
    cat = Category.all.sort_by { | cat | cat.name.downcase }
    cat << Category.new(name: "Other", id: 0)
    cat << Category.new(name: "All", id: -1)
    cat
  end
end
