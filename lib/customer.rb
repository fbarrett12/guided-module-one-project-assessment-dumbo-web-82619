class Customer < ActiveRecord::Base
    has_many :appointments
    has_many :hairdressers, through: :appointments

    def self.prompt
        prompt = TTY::Prompt.new 
    end

    def self.handle_new_customer
        name = self.prompt.ask("What is your name?")
        Customer.create(name: name)
    end

    def self.update_customer_name(old_name, new_name)
        x = self.find_by(name: old_name)
        x.update(name: new_name)
    end

    def self.destroy_customer_name(name)
        Customer.find_by(name: name).destroy
    end

    def self.set_appointment(hairdresser, customer, day, time)
        x = Hairdresser.find_by(name: hairdresser).id
        y = Customer.find_by(name: customer).id
        Appointment.create(customer_id: y, hairdresser_id: x, date: day, time: time)
    end

    def self.handle_returning_customer
        name = self.prompt.ask("What is your name?")
        Customer.find_by(name: name)
    end

    def schedule
        self.appointments.each do |app|
            puts "You have an appointment on #{app.date} at #{app.time}"
        end
    end

end