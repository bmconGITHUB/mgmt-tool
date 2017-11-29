class UpdateUsers < ActiveRecord::Migration
  def change
    @u = User.find_by( email:'mgmtapptool@gmail.com')
    # if there is no user with the mgmtapptool@gmail.com
    # in the users table the above find_by() method will return nil
    # nil shows there is no record in the table with that email
      if @u != nil
      @u.update_attribute :admin, true
      end
  end
end
