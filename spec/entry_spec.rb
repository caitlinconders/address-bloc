require_relative '../models/entry.rb'

RSpec.describe Entry do

    describe "attributes" do
        let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }

        it "responds to name" do
            expect(entry).to respond_to(:name)
        end

        it "reports its name" do
            expect(entry.name).to eq('Ada Lovelace')
        end

        it "responds to phone number" do
            expect(entry).to respond_to(:phone_number)
        end

        it "reports its phone_number" do
            expect(entry.phone_number).to eq('010.012.1815')
        end

        it "responds to email" do
            expect(entry).to respond_to(:email)
        end

        it "reports its email" do
            expect(entry.email).to eq('augusta.king@lovelace.com')
        end
    end

# We use a new describe block to separate the to_s test from the initializer tests. The # in front of to_s indicates that it is an instance method.
    describe "#to_s" do
        it "prints an entry as a string"  do
            entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
            expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
# we use eq to check that to_s returns a string equal to expected_string
            expect(entry.to_s).to eq(expected_string)
        end
    end
end
