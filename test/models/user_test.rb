require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
	def setup
		@user = User.new(name: "Example User", 
										 email: "user@example.com",
										 password: "foobar",
										 password_confirmation: "foobar")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.name = " "
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = " "
		assert_not @user.valid?
	end

	test "name should not be too long" do
		@user.name = "a" * 51
		assert_not @user.valid?
	end

	test "email address should be unique" do
		dup_user = @user.dup 
		dup_user.email = @user.email.upcase
		@user.save
		assert_not dup_user.valid?
	end

	test "email address should be saved as lower-case" do
		mixed_case_email = "Foo@Example.com"
		@user.email = mixed_case_email
		@user.save 
		assert_equal mixed_case_email.downcase, @user.email
	end

	test "authenticated? should return false for a user with nil digest" do
		assert_not @user.authenticated?('')
	end

end
