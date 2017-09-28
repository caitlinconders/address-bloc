require_relative '../models/address_book'

class MenuController
    attr_reader :address_book

    def initialize
        @address_book = AddressBook.new
    end

    def main_menu
        puts "Main Menu - #{address_book.entries.count} entries"
        puts "1 - View all entries"
        puts "2 - Create an entry"
        puts "3 - Search for an entry"
        puts "4 - Import entries from a CSV"
        puts "5 - Exit"
        print "Enter your selection: "

        ##retrieve user input from the command line using  gets. gets reads the next line from standard input, converts input to integer.
        selection = gets.to_i

        case selection
        when 1
            system "clear"
            view_all_entries
            main_menu
        when 2
            system "clear"
            create_entry
            main_menu
        when 3
            system "clear"
            search_entries
            main_menu
        when 4
            system "clear"
            read_csv
            main_menu
        when 5
            puts "Good-bye!"

            ##terminate the program
            exit(0)
        else
            system "clear"
            puts "Sorry, that is not a valid input"
            main_menu
        end
    end

    def view_all_entries
        address_book.entries.each do |entry|
            system "clear"
            puts entry.to_s

            ## we call  entry_submenu to display a submenu for each entry
            entry_submenu(entry)
        end

        system "clear"
        puts "End of entries"
    end

    def create_entry
        system "clear"
        puts  "New AddressBloc Entry"

        ##print to prompt the user for each Entry attribute. print works just like puts, except that it doesn't add a newline
        print "Name: "
        name = gets.chomp
        print "Phone number: "
        phone_number = gets.chomp
        print "Email: "
        email = gets.chomp

        address_book.add_entry(name, phone_number, email)

        system "clear"
        puts "New entry created"
    end

    def search_entries
    end

    def read_csv
    end

    def entry_submenu(entry)
        puts "n - next entry"
        puts "d - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"

        ##chomp removes any trailing whitespace from the string gets returns. This is necessary because "m " or "m\n" won't match  "m"
        selection = gets.chomp

        case selection
        when "n"
        when "d"
        when "e"
        when "m"
            system "clear"
            main_menu
        else
            system "clear"
            puts "#{selection} is not a valid input"
            entry_submenu(entry)
        end
    end
end
