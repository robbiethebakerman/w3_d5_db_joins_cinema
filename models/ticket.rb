require_relative("../db/sql_runner.rb")
require_relative("customer")
require_relative("film")
require_relative("screening")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
    @screening_id = options['screening_id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, screening_id)
      VALUES ($1, $2, $3)
      RETURNING *;"
    values = [@customer_id, @film_id, @screening_id]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
    # find customer and film
    customer = Customer.find(@customer_id)
    film = Film.find(@film_id)
    # reduce funds of customer class
    customer.funds -= film.price
    # update customer row in db
    customer.update
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
      SET (customer_id, film_id, screening_id) = ($1, $2, $3)
      WHERE id = $4;"
    values = [@customer_id, @film_id, @screening_id, @id]
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
