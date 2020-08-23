class HomeController < ApplicationController

  def index
    @groups = group_by_category Journal.not_cold
  end

  def cold
    @groups = group_by_category Journal.cold
    render 'index'
  end

  private
  def group_by_category(journals)
    journals.order(updated_at: :desc)
      .group_by(&:category)
      .sort_by { |cat, rest| cat.present? ? cat.name.downcase : "zzz"}
  end
end
