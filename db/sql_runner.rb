require( 'pg' )

class SqlRunner

  def self.run( sql, values = [] )
    begin
      db = PG.connect({ dbname: 'dd545br02ssm7k', host: 'ec2-3-213-192-58.compute-1.amazonaws.com', port: 5432, user: 'xhfwgpjtynxlgh', password: 'e403e46a9cffd5e544201af5f01b4cb52da6d39775d23e59a643dad6b546621b' })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
