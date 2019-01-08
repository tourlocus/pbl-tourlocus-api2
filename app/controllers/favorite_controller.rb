class FavoriteController < ApplicationController
  before_action :authenticate_user!, only: [:update]

  #-----------------------------------------
  # お気に入り登録
  #-----------------------------------------
  def post
  end

  #-----------------------------------------
  # お気に入り削除
  #-----------------------------------------
  def delete
  end

end
