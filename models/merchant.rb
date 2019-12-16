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

  def update()
    sql = "UPDATE merchants
          SET (
          name,
          active
          ) = (
          $1, $2
          ) WHERE id = $3"
    values = [@name, @active, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    result = SqlRunner.run(sql)
    return string_array = result.map { |merchant| Merchant.new(merchant) }
  end

  def self.update_active(array)
    for item in array
      if(item.active == 't')
        item.active = true
      else
        item.active = false
      end
    end
  end

  def self.availability_check(array)
    available_array =[]
    for item in array
      if item.active == 't'
        available_array << item
      end
    end
    return available_array
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
