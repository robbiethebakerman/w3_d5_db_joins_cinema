require_relative("../db/sql_runner.rb")

class Screening

  attr_reader :id
  attr_accessor :film_id, :screening_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @screening_time = options['screening_time']
  end

  def save()
    sql = "INSERT INTO screenings (film_id, screening_time)
      VALUES ($1, $2)
      RETURNING *;"
    values = [@film_id, @screening_time]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def self.find(id)
    sql = "SELECT *
      FROM screenings
      WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    screening = Screening.new(results[0])
    return screening
  end

  def update()
    sql = "UPDATE screenings
      SET (film_id, screening_time) = ($1, $2)
      WHERE id = $3;"
    values = [@film_id, @screening_time, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings
      WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT *
      FROM screenings;"
    results = SqlRunner.run(sql)
    screenings = results.map { |result| Screening.new(result) }
    return screenings
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end

end
