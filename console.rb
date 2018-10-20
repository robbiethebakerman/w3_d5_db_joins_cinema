require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Customer.delete_all
# Film.delete_all
# Ticket.delete_all

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

# film_shining = Film.new ({
#   'title' => 'The Shining',
#   'price' => 5
# })
#
# film_shining.save
#
# ticket_1 = Ticket.new ({
#   'customer_id' => customer_bob.id,
#   'film_id' => film_shining.id
#   })
#
# ticket_1.save

customer_bob.name = 'Bobby-Boy Billy-Bakes'
customer_bob.update

# film_shining.name = 'The Shinning (Simpsons parody)'
# film_shining.update
#
# ticket_1.customer_id = customer_jill.id
# ticket1.update

customer_bob.delete
# film_shining.delete
# ticket_1.delete


binding.pry
nil
