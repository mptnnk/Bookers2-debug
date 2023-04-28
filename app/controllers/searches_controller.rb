class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    # formのoptions_for_selectオプションからモデルの情報を取得
    @content = params[:content]
    # contentは検索ワード
    @method = params[:method]
    # formのoptions_for_selectオプションから一致の度合いを取得（完全一致等）
    if @model == 'user'
      @records = User.search_for(@content, @method)
    elsif @model == 'book'
      @records = Book.search_for(@content, @method)
		elsif @model == 'tag'
			@records = Tag.search_books_for(@content, @method)
    end
  end
  
end
