class AddDefaulStatus < ActiveRecord::Migration[6.1]
  def change
    Post.where(status: nil).update_all(status: 'open')
  end
end
