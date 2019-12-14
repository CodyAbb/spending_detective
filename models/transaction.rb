require_relative('../db/sql_runner')
class Transaction

  attr_reader :id
  attr_accessor :transaction_date, :month, :tag_id, :merchant_id

  def initialize(options)
    @transaction_date = options['transaction_date'].to_i
    @month = options['month']
    @tag_id = options['tag_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO transactions
    (
      transaction_date, month, tag_id, merchant_id
    ) VALUES (
      $1, $2, $3, $4
    ) RETURNING id"
    values = [@transaction_date, @month, @tag_id, @merchant_id]
    result = SqlRunner.run(sql, values)
    @id = result.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    result = SqlRunner.run(sql)
    return result.map { |transaction| Transaction.new(transaction) }
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return result.map { |transaction| Transaction.new(transaction)  }
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

end
