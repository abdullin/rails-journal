class HomeController < ApplicationController

  def index
    @groups = group_by_category Journal.not_cold
    @future = get_future_journals
  end

  def cold
    @groups = group_by_category Journal.cold
    @future = get_future_journals
    render 'index'
  end

  private
  def group_by_category(journals)
    journals.order(updated_at: :desc)
      .group_by(&:category)
      .sort_by { |cat, rest| cat.present? ? cat.name.downcase : "zzz"}
  end

  def get_future_journals
    Note.future
      .joins(:journal)
      .select('journals.id as jid, min(notes.created_at) as most_recent')
      .group('journals.id')
      .map{ |c| [c.jid,c.most_recent]}.to_h 
  end
end
