class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  # userの引数にはviewでメソッドを呼び出すときにcurrent_userを代入する。
  
  def save_tags(savebook_tags)
    # 現在のユーザーの持っているskillを引っ張ってくる
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 今bookが持っているタグと今回保存されたものの差をすでにあるタグと比較する。古いタグは消す。
    old_tags = current_tags - savebook_tags
    # 今回保存されたものと現在との差を新しいタグと比較する。新しいタグは保存する
    new_tags = savebook_tags - current_tags
    
    # destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
    
    # create new taggings:
    new_tags.each do |new_name|
      book_tag = Tag.find_or_create_by(name:new_name)
      # 配列に保存
      self.tags << book_tag
    end
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%' + content)
    else
      Book.where('title LIKE ?', '%' + content + '%')
    end
  end
end