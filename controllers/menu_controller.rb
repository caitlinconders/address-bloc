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
        puts "5 - View Entry Number"
        puts "6 - Nuke all entires"
        puts "7 - Exit"
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
            system "clear"
            entry_n_submenu
            main_menu
        when 6
            system "clear"
            @address_book.nuke
            puts "All entries deleted!"
            main_menu
        when 7
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

        # we get the name that the user wants to search for and store it in name
        print "Search by name: "
        name = gets.chomp

        #we call search on address_book which will either return a match or nil, it will never return an empty string since import_from_csv will fail if an entry does not have a name.
        match = address_book.binary_search(name)
        system "clear"

        #if a match is found, the submenu is called.
        if match
            puts match.to_s
            search_submenu(match)
        else
            puts "No match found for #{name}"
        end
    end

    def search_submenu(entry)

        puts "\nd - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"

        selection = gets.chomp

        case selection
            when "d"
                system "clear"
                delete_entry(entry)
                main_menu
            when "e"
                edit_entry(entry)
                system "clear"
                main_menu
            when  "m"
                system "clear"
                puts "#{selections} is not a valid input"
                puts entry.to_s
                search_submenu(entry)
            end
        end

    def read_csv
        print "Enter CSV file to import: "
        file_name = gets.chomp

        if file_name.empty?
            system "clear"
            puts "No CSV file read"
            main_menu
        end

        # Wse import the specified file with import_from_csv on address_book. We then clear the screen and print the number of entries that were read from the file. All of these commands are wrapped in a begin/rescue block. begin will protect the program from crashing if an exception is thrown.
        begin
            entry_count = address_book.import_from_csv(file_name).count
            system "clear"
            puts "#{entry_count} new entries added from #{file_name}"
        rescue
            puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
            read_csv
        end
    end

    def entry_n_submenu
        puts "Which entry number would you like to view?"

        selection = gets.chomp.to_i

        if selection < @address_book.entries.count
            puts @address_book.entries[selection]
            puts "Press enter to return to the main menu"
            gets.chomp
            system "clear"
        else
            puts "#{selection} is not a valid input"
            entry_n_submenu
        end
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
            delete_entry(entry)
        when "e"
            edit_entry(entry)
            entry_submenu(entry)
        when "m"
            system "clear"
            main_menu
        else
            system "clear"
            puts "#{selection} is not a valid input"
            entry_submenu(entry)
        end
    end

    def delete_entry(entry)
        address_book.entries.delete(entry)
        puts "#{entry.name} has been deleted"
    end

    def edit_entry(entry)

        print "Updated name: "
        name = gets.chomp
        print "Updated phone_number: "
        phone_number = gets.chomp
        print "Updated email: "
        email = gets.chomp

        # We use !attribute.empty? to set attributes on entry only if a valid attribute was read from user input.
        entry.name = name if !name.empty?
        entry.phone_number = phone_number if !phone_number.empty?
        entry.email = email if !email.empty?
        system "clear"

        puts "Updated entry: "
        puts entry
    end
end
