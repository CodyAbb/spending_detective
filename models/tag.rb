require_relative('../db/sql_runner')
class Tag

  attr_reader :id
  attr_accessor :type, :description

  def initialize(options)
    @type = options['type']
    @description = options['description']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO tags
    (
      type, description
    ) VALUES (
      $1, $2
    ) RETURNING id"
    values = [@type, @description]
    result = SqlRunner.run(sql, values)
    @id = result.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tags"
    result = SqlRunner.run(sql)
    return result.map { |tag| Tag.new(tag) }
  end

  def find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return result.map { |tag| Tag.new(tag)  }
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    result = SqlRunner.run(sql)
  end

end
