require('pry')
require_relative('../models/tag')
require_relative('../models/merchant')


Tag.delete_all()
Merchant.delete_all()


#Seed data for spending tags
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

#seed data for merchant tags
merchant1 = Merchant.new({
  "name" => "Tesco",
  "active" => true
  })
merchant1.save()

merchant2 = Merchant.new({
  "name" => "Chilli Grill",
  "active" => false
  })
merchant2.save()

merchant3 = Merchant.new({
  "name" => "Cineworld",
  "active" => true
  })
merchant3.save()

merchant4 = Merchant.new({
  "name" => "Netflix",
  "active" => true
  })
merchant4.save()

merchant5 = Merchant.new({
  "name" => "SSE",
  "active" => true
  })
merchant5.save()

binding.pry
nil
