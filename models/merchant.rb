require_relative('../db/sql_runner')
class Merchant

  attr_reader :id
  attr_accessor :name, :active

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @active = options['active']
  end

  def save()
    sql = "INSERT INTO merchants
    (
      name, active
    ) VALUES (
      $1, $2
    ) RETURNING id"
    values = [@name, @active]
    result = SqlRunner.run(sql, values)
    @id = result.first()['id'].to_i
  end

  def availability()
    if @active == true
      return "Available"
    else
      return "Currently Unavailable"
    end
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    result = SqlRunner.run(sql)
    return result.map { |merchant| Merchant.new(merchant) }
  end

  def self.find(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Merchant.new( results.first )
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM merchants where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
