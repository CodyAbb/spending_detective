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

end
