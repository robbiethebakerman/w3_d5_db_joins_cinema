require_relative("../db/sql_runner.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price)
      VALUES ($1, $2)
      RETURNING *;"
    values = [@title, @price]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def self.find(id)
    sql = "SELECT *
      FROM films
      WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    film = Film.new(results[0])
    return film
  end

  def update()
    sql = "UPDATE films
      SET (title, price) = ($1, $2)
      WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films
      WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT *
      FROM films;"
    results = SqlRunner.run(sql)
    films = results.map { |result| Film.new(result) }
    return films
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

# REFACTOR for screenings
# Added "DISTINCT" command to sql to make sure each customer only returned once
# (even if customer has book to see mupltiple screenings of the same film)

  def customers()
    sql = "SELECT DISTINCT customers.*
      FROM customers
      INNER JOIN tickets
      ON customers.id = tickets.customer_id
      WHERE film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    customers = results.map { |result| Customer.new(result) }
    return customers
  end

  def no_of_customers
    sql = "SELECT COUNT (customers.id)
      FROM customers
      INNER JOIN tickets
      ON customers.id = tickets.customer_id
      WHERE film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    count = results[0]['count'].to_i
    return count
  end

  def no_of_unique_customers
    sql = "SELECT DISTINCT customers.*
      FROM customers
      INNER JOIN tickets
      ON customers.id = tickets.customer_id
      WHERE film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    customers = results.map { |result| Customer.new(result) }
    return customers.length
  end

end
