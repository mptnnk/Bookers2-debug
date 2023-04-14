class Relationship < ApplicationRecord
  
  belongs_to :follower, class_name: "User"
  # followerだけの記述だとfollowersテーブルを参照しにいってしまうので、クラス名（モデル名）を指定すると、usersテーブルを参照しにいくようになる
  belongs_to :followed, class_name: "User"
  
end
