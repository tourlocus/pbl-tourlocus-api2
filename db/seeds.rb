# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

### 新しいテストデータ(csv読込, excelで作っちゃったのでshiftjis->utf8にしてます) ###
require "csv"

# users
open('db/csv/users.csv', "rt:Shift_JIS:UTF-8", undef: :replace) do |f|
  CSV.new(f).each do |row|
    User.create!(
      :name     => row[0],
      :password => row[1],
      :email    => row[2],
      :birthday => row[3],
      :gender   => row[4],
      :intro    => row[5],
      :icon     => row[6]
    )
  end
end

# articles
open('db/csv/articles.csv', "rt:Shift_JIS:UTF-8", undef: :replace) do |f|
  CSV.new(f).each do |row|
    Article.create!(
      :title      => row[0],
      :content    => row[1],
      :user_id    => row[2],
      :created_at => row[3]
    )
  end
end

# tags
CSV.foreach('db/csv/tags.csv', encoding: 'Shift_JIS:UTF-8') do |row|
  Tag.create!(:name => row[0])
end

# article_tags
CSV.foreach('db/csv/article_tags.csv', encoding: 'Shift_JIS:UTF-8') do |row|
  ArticleTag.create!(
    :article_id => row[0],
    :tag_id     => row[1]
  )
end

# media_files
CSV.foreach('db/csv/images.csv', encoding: 'Shift_JIS:UTF-8') do |row|
  MediaFile.create!(
    :media      => open("./public/uploads/"+row[0]),
    :article_id => row[1]
  )
end

# presents
open('db/csv/presents.csv', "rt:Shift_JIS:UTF-8", undef: :replace) do |f|
  CSV.new(f).each do |row|
    Present.create!(
      :name       => row[0],
      :price      => row[1],
      :num        => row[2],
      :target     => row[3],
      :content    => row[4],
      :image      => open("./public/uploads/"+row[5]),
      :article_id => row[6]
    )
  end
end