class Hairdresser < ActiveRecord::Base
    has_many :appointments
    has_many :customers, through: :appointments

    def self.prompt
        prompt = TTY::Prompt.new 
    end

    def self.handle_new_hairdresser
        name = self.prompt.ask("What is your name?")
        Hairdresser.create(name: name)
    end

    def self.update_hairdresser_name(old_name, new_name)
        x = self.find_by(name: old_name)
        x.update(name: new_name)
    end

    def self.destroy_hairdresser_name(name)
        Hairdresser.find_by(name: name).destroy
    end

    def schedule
        self.appointments.each do |app|
            puts "You have an appointment on #{app.date} at #{app.time}"
        end
    end

    def self.handle_returning_hairdresser
        name = self.prompt.ask("What is your name?")
        Hairdresser.find_by(name: name)
    end
    
    #Hairdresser.first.appointments.find { |app| app.date == date && app.time == time }
end