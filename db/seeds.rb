# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Contact.__elasticsearch__.create_index!
Note.__elasticsearch__.create_index!



contact1 =  Contact.create!(first_name: 'narendra', last_name: 'modi')
contact2 =  Contact.create!(first_name: 'barak', last_name: 'obama')
contact3 =  Contact.create!(first_name: 'trump', last_name: 'donald')
contact4 =  Contact.create!(first_name: 'trump', last_name: 'donald')


note1 = Note.create!(notes: 'I became pM two times', contact: contact1)
note2 = Note.create!(notes: 'It is going to be record if i bacome third time', contact: contact1)
note3 = Note.create!(notes: 'I became pM two times', contact: contact2)
note4 = Note.create!(notes: 'Iam going to become pM two times', contact: contact3)
note5 = Note.create!(notes: 'Iam going to become pM three times', contact: contact4)


