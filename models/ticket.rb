require_relative("../db/sql_runner.rb")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
      VALUES ($1, $2)
      RETURNING *;"
    values = [@customer_id, @film_id]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def self.find(id)
    sql = "SELECT *
      FROM tickets
      WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    ticket = Ticket.new(results[0])
    return ticket
  end

  def update()
    sql = "UPDATE tickets
      SET (customer_id, film_id) = ($1, $2)
      WHERE id = $3;"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets
      WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT *
      FROM tickets;"
    results = SqlRunner.run(sql)
    tickets = results.map { |result| Ticket.new(result) }
    return tickets
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

end
