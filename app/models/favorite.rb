class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates_uniqueness_of :book_id, scope: :user_id
  # validates_uniqueness_of 属性の値が一意であることをバリデーションする
  # :scopeオプション　範囲を指定して一意かどうかをチェックしてくれる（今回はuser_idで範囲を限定）
  # 単に「validates: book_id, uniqueness: true」のみで一意性の指定をすると、全ユーザーの中で1人しか（1投稿に対して物理的に1つしか）いいねが押せなくなる
end
