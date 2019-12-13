require('pry')
require_relative('../models/tag')

Tag.delete_all()

tag1 = Tag.new({
  "type" => "Groceries",
  "description" => ""
  })
tag1.save()

tag2 = Tag.new({
  "type" => "Entertainment",
  "description" => "Cinema with Jane"
  })
tag2.save()

tag3 = Tag.new({
  "type" => "Eating Out",
  "description" => "Fancy meal with Tinder date"
  })
tag3.save()

tag4 = Tag.new({
  "type" => "Bills",
  "description" => "Electricity payment"
  })
tag4.save()

tag5 = Tag.new({
  "type" => "Membership",
  "description" => ""
  })
tag5.save()

tag6 = Tag.new({
  "type" => "Eating Out",
  "description" => "Had a kebab after a night out, bad!"
  })
tag6.save()

binding.pry
nil
