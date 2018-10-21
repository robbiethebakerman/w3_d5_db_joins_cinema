require_relative("../db/sql_runner.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
      VALUES ($1, $2)
      RETURNING *;"
    values = [@name, @funds]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def self.find(id)
    sql = "SELECT *
      FROM customers
      WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    customer = Customer.new(results[0])
    return customer
  end

  def update()
    sql = "UPDATE customers
      SET (name, funds) = ($1, $2)
      WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers
      WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT *
      FROM customers;"
    results = SqlRunner.run(sql)
    customers = results.map { |result| Customer.new(result) }
    return customers
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT films.*
      FROM films
      INNER JOIN tickets
      ON films.id = tickets.film_id
      WHERE customer_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    films = results.map { |result| Film.new(result) }
    return films
  end

  def no_of_tickets()
    sql = "SELECT COUNT (customer_id)
      FROM tickets
      WHERE customer_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    count = results[0]['count'].to_i
    return count
  end

end
