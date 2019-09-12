class Interface
attr_accessor :prompt, :user
    def initialize()
        @prompt = TTY::Prompt.new
    end

    def welcome
        art= puts <<-'EOF'
        _____ _                    _____ _                 
        / ____| |                  / ____| |                
       | |    | |__   ___  _ __   | |    | |__   ___  _ __  
       | |    | '_ \ / _ \| '_ \  | |    | '_ \ / _ \| '_ \ 
       | |____| | | | (_) | |_) | | |____| | | | (_) | |_) |
        \_____|_| |_|\___/| .__/   \_____|_| |_|\___/| .__/ 
                          | |                        | |    
                          |_|                        |_|   
                                                EOF
        puts ""
        puts ""                                        
        art

        puts "Welcome to Chop Chop!"
        puts ""
        puts ""
            choice = self.prompt.select("Are you a new user or a returning user?") do |menu|
                menu.choice "New User"
                menu.choice "Returning User"
        end
    

        case choice
            when "New User"
                option = self.prompt.select("Are you a customer or a professional") do |list|
                    list.choice "Customer"
                    list.choice "Professional"
                end

            case option
                when "Customer"
                    Customer.handle_new_customer
                when "Professional"
                    Hairdresser.handle_new_hairdresser 
            end

            when "Returning User"
                option = self.prompt.select("Are you a customer or a professional") do |list|
                    list.choice "Customer"
                    list.choice "Professional"
                end

            case option
                when "Customer"
                    Customer.handle_returning_customer
                when "Professional"
                    Hairdresser.handle_returning_hairdresser 
            end
        end
    end


    def main_menu
        system "clear"
            choice = self.prompt.select("Select options") do |menu|
                menu.choice "Schedule Appointment"
                menu.choice "Update Info"
                menu.choice "View Appointment"
                menu.choice "Cancel Appointment"
                menu.choice "Exit"
            end
        case choice
            when "Schedule Appointment"
                system "clear"

                hd_arr = Hairdresser.all.map {|hd| hd.name}
                hairdresser = self.prompt.select("Who's your hairdresser", hd_arr)
                hairdresser_instance = Hairdresser.find_by(name: hairdresser)

                day = self.prompt.ask("What day would you like to scheule an appointment? ex. March 20:")
                time = self.prompt.ask("What time would you like to schedule an appointment? ex 2pm:")

                Appointment.create(customer_id: self.user.id, hairdresser_id: hairdresser_instance.id, date: day, time: time)
                puts "Your appointment is set!"
                return main_menu

            when "Update Info"
                system "clear"
                y = self.prompt.ask("What name would you like to change your name to?")

                if Hairdresser.find_by(name: self.user.name)
                    Hairdresser.update_hairdresser_name(self.user.name, y)
                    puts "Your new name is #{y}."
                    return main_menu
                elsif Customer.find_by(name: self.user.name)
                    Customer.update_customer_name(self.user.name, y)
                    puts "Your new name is #{y}."
                    return main_menu 
                else
                    puts "That name is not found"
                    return main_menu
                end

            when "View Appointment"
                system "clear"
                self.user.reload
                self.user.schedule
                sleep 5
                return main_menu
            
            when "Cancel Appointment"
                system "clear"

                app_arr = self.user.appointments.map {|app| app.date}

                x = self.prompt.select("What appointment would you like to cancel", app_arr)

                self.user.appointments.find_by(date: x).destroy

                puts "Your appointment has been canceled"

                return main_menu

        end
    end
end
