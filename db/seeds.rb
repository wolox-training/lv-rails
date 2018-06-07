# rails db:seed

user = User.create(email: 'test@wolox.com.ar', password: '123123123', password_confirmation: '123123123', first_name: 'Test', last_name: 'TestLastName', locale: 'es')
book = Book.create(genre: 'Drama',author: 'King', image: 'photo.png' ,title: 'It crew' ,publisher: 'editor', year: '2003')
rent = Rent.create(user_id: 1, book_id: 1, from: Date.new(2018,5,7), to: Date.new(2018,5,9))
admin = AdminUser.create!(email: 'admin@wolox.com.ar', password: '123123123', password_confirmation: '123123123') if Rails.env.development?
