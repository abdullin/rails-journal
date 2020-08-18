class MakeFutureDefaultFalse < ActiveRecord::Migration[6.0]
  def change
    change_column_default :notes, :is_future, default: false
  end
end
