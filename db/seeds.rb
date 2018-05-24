# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'test@wolox.com.ar', password: '123123123', password_confirmation: '123123123', first_name: 'Test', last_name: 'TestLastName', locale: 'es')
book = Book.create(genre: 'Drama',author: 'King', image: 'photo.png' ,title: 'It crew' ,publisher: 'editor', year: '2003')
rent = Rent.create(user: user, book: book, from: Date.new(2018,5,7), to: Date.new(2018,5,9))