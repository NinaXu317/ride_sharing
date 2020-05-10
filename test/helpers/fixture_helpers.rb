module FixtureHelpers
  def encrypted_password(password = '111111')
    User.new.send(:password_digest, password)
  end
end