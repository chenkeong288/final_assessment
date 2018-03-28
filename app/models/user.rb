class User < ApplicationRecord
  has_secure_password

  has_many :listings, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates_uniqueness_of :email                               # to validate any identifier we want to use on the user model (eg.validate format of the email, length of password). We don't need to validate password because it is automatically handled by has_secure_password
  
  # for Google Login
  def self.from_omniauth(access_token)
      #Code for OmniAuth login
      data = access_token.info                                # save info of the gmail account into variable 'Data'. Variable Data is Hash
      user = User.where(email: data['email']).first           # this code check the email in variable 'data' above to see whether the email of the gmail account is in database or not. If in database means the gmail account has been used before for this website, thus enable gmail login whereby the login function is handled by google_auth2 method in users controller. Or else then it goes to Signup code below to create new user using the gmail account

      #Code for OmniAuth Signup (for circumstance where the gmail account haven't been used before)
      unless user
          user = User.create(
             first_name: data['first_name'],                  # Google account info is saved into variable Data which return a hash from the code above. From the Data hash, we use the hashkey 'first_name' to access first name value of google account, and save it into the first_name column in Users table
             last_name: data['last_name'],                    # Google account info is saved into variable Data which return a hash from the code above. From the Data hash, we use the hashkey 'last_name' to access last name value of google account, and save it into the last_name column in Users table
             email: data['email'],                          
             password_digest: SecureRandom.hex(10)            # password have to be SecureRandom because we are now relying Gmail
          )
      end
      user
  end

end
