require 'faker'
include Faker
Customer.destroy_all
Hairdresser.destroy_all
Appointment.destroy_all
Customer.reset_pk_sequence
Hairdresser.reset_pk_sequence
Appointment.reset_pk_sequence

5.times do 
    Customer.create(name: Faker::Name.name)
end

5.times do 
    Hairdresser.create(
        name: Faker::Name.name
    )
end

# 5.times do 
#     number = rand(1..5)
#     Appointment.create(customer_id: number, hairdresser_id: number)
# end

Appointment.create(customer_id: Customer.first.id , hairdresser_id: Hairdresser.first.id)
Appointment.create(customer_id: Customer.second.id , hairdresser_id: Hairdresser.first.id)
Appointment.create(customer_id: Customer.third.id , hairdresser_id: Hairdresser.first.id)

Appointment.create(customer_id: Customer.second.id , hairdresser_id: Hairdresser.second.id)
Appointment.create(customer_id: Customer.third.id , hairdresser_id: Hairdresser.third.id)
Appointment.create(customer_id: Customer.fourth.id , hairdresser_id: Hairdresser.fourth.id)
Appointment.create(customer_id: Customer.fifth.id , hairdresser_id: Hairdresser.fifth.id)

