require_relative('../db/sql_runner')
require_relative('./merchant')
class Tag

  attr_reader :id
  attr_accessor :type

  def initialize(options)
    @type = options['type']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO tags
    (
      type
    ) VALUES (
      $1
    ) RETURNING id"
    values = [@type]
    result = SqlRunner.run(sql, values)
    @id = result.first()['id'].to_i
  end

  def merchants()
    sql = "SELECT merchants.* FROM merchants
          INNER JOIN transactions
          ON transactions.merchant_id = merchants.id
          WHERE tag_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |merchant| Merchant.new(merchant) }
  end

  def self.all()
    sql = "SELECT * FROM tags"
    result = SqlRunner.run(sql)
    return result.map { |tag| Tag.new(tag) }
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Tag.new( results.first )
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    result = SqlRunner.run(sql)
  end

end
