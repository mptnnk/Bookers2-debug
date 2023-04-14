class Relationship < ApplicationRecord
  
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  # 同じテーブル同士を結ぶ必要があるので、カラム名にuser_idなどのわかりやすいものは使えない
  # フォローするのもされるのもユーザーであるため、少なくとも片方はuser_id以外のカラム名にする必要がある。
  
end
