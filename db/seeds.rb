require('pry')
require_relative('../models/tag')
require_relative('../models/merchant')
require_relative('../models/transaction')


Transaction.delete_all()
Tag.delete_all()
Merchant.delete_all()


#Seed data for spending tags
tag1 = Tag.new({
  "type" => "Groceries"
  })
tag1.save()

tag2 = Tag.new({
  "type" => "Entertainment"
  })
tag2.save()

tag3 = Tag.new({
  "type" => "Eating Out"
  })
tag3.save()

tag4 = Tag.new({
  "type" => "Bills"
  })
tag4.save()

tag5 = Tag.new({
  "type" => "Membership"
  })
tag5.save()

tag6 = Tag.new({
  "type" => "Eating Out"
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


#seed data for transactions
transaction1 = Transaction.new({
  "transaction_date" => "2019-11-22",
  "amount" => 7.48,
  "description" => "",
  "tag_id" => tag1.id,
  "merchant_id" => merchant1.id
  })
transaction1.save()

transaction2 = Transaction.new({
  "transaction_date" => "2019-12-01",
  "amount" => 10.50,
  "description" => "Cinema with Jane",
  "tag_id" => tag2.id,
  "merchant_id" => merchant3.id
  })
transaction2.save()

transaction3 = Transaction.new({
  "transaction_date" => "2019-11-25",
  "amount" => 23.99,
  "description" => "Fancy meal with Tinder date",
  "tag_id" => tag4.id,
  "merchant_id" => merchant5.id
  })
transaction3.save()

transaction4 = Transaction.new({
  "transaction_date" => "2019-12-05",
  "amount" => 6.99,
  "description" => "Electricity payment",
  "tag_id" => tag3.id,
  "merchant_id" => merchant2.id
  })
transaction4.save()

transaction5 = Transaction.new({
  "transaction_date" => "2019-12-07",
  "amount" => 7.00,
  "description" => "",
  "tag_id" => tag5.id,
  "merchant_id" => merchant4.id
  })
transaction5.save()


binding.pry
nil
