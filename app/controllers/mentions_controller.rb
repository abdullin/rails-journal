class MentionsController < ApplicationController

  def index
    @mentions = Person.all.map do |p|
      { 
        name: p.name, 
        sgid: p.attachable_sgid,
        content: render_to_string(p, formats: [:html]),
      }
    end

    render json: @mentions
  end
end
