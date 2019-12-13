require_relative('../db/sql_runner')
class Tag

  attr_reader :id
  attr_accessor :type

  def intialize(options)
    @type = options['type']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSET INTO tags
    (
      type
    ) VALUES (
      $1
    ) RETURNING id"
    values = [@type]
    result = SqlRunner(sql, values)
    @id = result.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tags"
    result = SqlRunner(sql)
    return result.map { |tag| Tag.new(tag) }
  end

  def find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    result = SqlRunner(sql, values)
    return result.map { |tag| Tag.new(tag)  }
  end

end
