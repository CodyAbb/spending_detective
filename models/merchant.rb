require_relative('..db/sql_runner')
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

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end


end
