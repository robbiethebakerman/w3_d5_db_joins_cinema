require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

Customer.delete_all
Film.delete_all
Ticket.delete_all
Screening.delete_all

customer_bob = Customer.new ({
  'name' => 'Bob Baker',
  'funds' => 100
})

customer_jill = Customer.new ({
  'name' => 'Jill Jeffreys',
  'funds' => 75
})

customer_bob.save
customer_jill.save

film_shining = Film.new ({
  'title' => 'The Shining',
  'price' => 10
})

film_mean = Film.new ({
  'title' => 'Mean Girls',
  'price' => 7
})

film_shining.save
film_mean.save

screening_shining_1 = Screening.new({
  'film_id' => film_shining.id,
  'screening_time' => '12:00'
  })

screening_shining_2 = Screening.new({
  'film_id' => film_shining.id,
  'screening_time' => '15:00'
  })

screening_mean_1 = Screening.new({
  'film_id' => film_mean.id,
  'screening_time' => '18:00'
  })

screening_shining_1.save
screening_shining_2.save
screening_mean_1.save

ticket_1 = Ticket.new ({
  'customer_id' => customer_bob.id,
  'film_id' => film_shining.id,
  'screening_id' => screening_shining_1.id
  })

ticket_2 = Ticket.new ({
  'customer_id' => customer_jill.id,
  'film_id' => film_mean.id,
  'screening_id' => screening_mean_1.id
  })

ticket_3 = Ticket.new ({
  'customer_id' => customer_jill.id,
  'film_id' => film_shining.id,
  'screening_id' => screening_shining_1.id
  })

ticket_4 = Ticket.new ({
  'customer_id' => customer_jill.id,
  'film_id' => film_shining.id,
  'screening_id' => screening_shining_2.id
  })

ticket_1.save
ticket_2.save
ticket_3.save
ticket_4.save

# customer_bob.name = 'Bobby-Boy Billy-Bakes'
# customer_bob.update
#
# film_shining.title = 'The Shinning (Simpsons parody)'
# film_shining.update
#
# screening_shining_1.screening_time = '00:00'
# screening_shining_1.update
#
# ticket_1.customer_id = customer_jill.id
# ticket_1.update

# # customer_bob.delete
# # film_shining.delete
# screening_shining_1.delete
# ticket_1.delete



binding.pry
nil
