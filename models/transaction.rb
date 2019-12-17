require 'date'
require 'time'

require_relative('../db/sql_runner')
class Transaction

  attr_reader :id
  attr_accessor :transaction_date, :amount, :description, :tag_id, :merchant_id

  def initialize(options)
    @transaction_date = options['transaction_date']
    @amount = options['amount'].to_f
    @description = options['description']
    @tag_id = options['tag_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO transactions
    (
      transaction_date, amount, description, tag_id, merchant_id
    ) VALUES (
      $1, $2, $3, $4, $5
    ) RETURNING id"
    values = [@transaction_date, @amount, @description, @tag_id, @merchant_id]
    result = SqlRunner.run(sql, values)
    @id = result.first()['id'].to_i
  end

  def update()
    sql = "UPDATE transactions
          SET (
            transaction_date, amount, description, tag_id, merchant_id
          ) = (
          $1, $2, $3, $4, $5
          ) WHERE id = $7"
    values = [@transaction_date, @amount, @description, @tag_id, @merchant_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT id,
          transaction_date,
          amount,
          description,
          tag_id,
          merchant_id From transactions"
    result = SqlRunner.run(sql)
    return result.map { |transaction| Transaction.new(transaction) }
  end

  def self.find(id)
    sql = "SELECT id,
          transaction_date,
          amount,
          description,
          tag_id,
          merchant_id From transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Transaction.new(result.first)
  end

  def tag()
   sql = "SELECT * FROM tags WHERE id = $1"
   values = [@tag_id]
   results = SqlRunner.run( sql, values )
   return Tag.new( results.first )
  end

  def merchant()
   sql = "SELECT * FROM merchants WHERE id = $1"
   values = [@merchant_id]
   results = SqlRunner.run( sql, values )
   return Merchant.new( results.first )
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM transactions where id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.total_transactions()
    sql = "SELECT amount FROM transactions"
    result = SqlRunner.run(sql)
    result
    result_array = result.map { |result| result}
    values = result_array.map{|h| h['amount'].to_f}.compact
    return values.reduce(0){|sum, n| sum + n}
  end

  #parses sql string and converts into uk date format
  def flip_date(date)
    d = Date.parse(date)
    return d.strftime('%d/%m/%y').to_s
  end

  def month_parse(date)
    d =  Date.parse(date).month
    return d.to_s
  end


end
