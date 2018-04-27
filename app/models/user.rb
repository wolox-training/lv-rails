class User < ActiveRecord < Base
  include PersonData
  include Account

  def initialize(args)
    args.each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    validate_password_equality
  end

  def to_s
    "User[ First name: #{first_name}, Last name: #{last_name}, Email: #{email} ]"
  end

  # Requeriment: should not be blank
  validates :first_name, presence: true
  validates :last_name, presence: true
end
# User.create(email: 'test@wolox.com.ar', password: '123123123',
# password_confirmation: '123123123', first_name: 'Test', last_name: 'TestLastName')
