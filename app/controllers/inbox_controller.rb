
class InboxController < ApplicationController
  def index
    @items = InboxItem.all
  end

  def new
    @item = InboxItem.new()
  end

  def create
    InboxItem.create!(item_params)
    redirect_to action: "index"
  end


  def destroy
    note = InboxItem.find(params[:id])
    note.delete

    redirect_to action: "index"
  end

  private
  def item_params
    params.require(:inbox_item).permit(:content)
  end
end
