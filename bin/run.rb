require_relative '../config/environment'


cli = Interface.new

user_object = cli.welcome 

while user_object == nil
    user_object = cli.welcome
end

cli.user = user_object
cli.main_menu


binding.pry
0