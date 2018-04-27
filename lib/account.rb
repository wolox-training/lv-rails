module Account
  attr_accessor :email, :password, :password_confirmation

  # Requeriment: When create an account: password
  # and password_confirmation must be equals

  def validate_password_equality
    err_msg = 'Password and Password_confirmation are not equals'
    raise ArgumentError, err_msg if password != password_confirmation
  end
end
