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

    @words, @letters = count_words_and_letters(@notes)
  end

  private 

  def load_categories
    cat = Category.all.sort_by { | cat | cat.name.downcase }
    cat << Category.new(name: "Other", id: 0)
    cat << Category.new(name: "All", id: -1)
    cat
  end



  def count_words_and_letters(notes)
    texts = notes.map { |n| n.content.to_plain_text }
    words = texts.reduce(0) { |mem,x| mem+x.split.size }

    letters = texts.reduce(0) { |mem,x| mem+x.size }
    return words, letters
  end
end
