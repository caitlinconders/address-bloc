puts "Welcome to AddressBloc!"

require_relative 'controllers/menu_controller'

##create a new MenuController when AddressBloc starts
menu = MenuController.new

##use  system "clear" to clear the command line
system "clear"
puts "Welcome to AddressBloc!"

##call main_menu to display the menu.
menu.main_menu
