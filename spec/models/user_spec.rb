require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attribute' do
    @user = User.new(name: "name", email: "test@test.com", password: "password", password_confirmation: "password")
    expect(@user).to be_valid, @user.errors.full_messages
  end

  it 'it not valid without a name' do
    @user = User.new( email: "test@test.com", password: "test", password_confirmation: "test")
    expect(@user).to_not be_valid
    expect(@user.errors.full_messages.first).to eq "Name can't be blank"
  end

  describe 'password' do 
    it 'is not valid without password' do
      @user = User.new(name: "name", email: "test@test.com", password_confirmation: "password")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password can't be blank"
    end

    it 'is not valid without password confirmation' do
      @user = User.new(name: "test", email: "test", password: "test")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eql "Password confirmation can't be blank"
    end

    it 'is not valid with a password confirmation different from the password' do
      @user = User.new(name: "name", email: "test@test.com", password: "pasword", password_confirmation: "PASSWORD")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password confirmation doesn't match Password"
    end

    it 'is not valid with a password is less than 5 char' do
      @user = User.new(name: "name", email: "test@test.com", password: "pass", password_confirmation: "pass")
      expect(@user).to_not be_valid
    end
  end

  describe 'email' do
    it 'is not valid without an email' do
      @user = User.new(name: "name", password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Email can't be blank"
    end
    it 'is not valid with an already existing email address' do
      @user = User.new(name: "name", email: "test@test.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      @new_user = User.new(name: "name", email: "test@test.com", password: "password", password_confirmation: "password")
      expect(@new_user).to_not be_valid, @user.errors.full_messages   
    end

    it 'is not valid with the same email but different cases' do
      @user = User.new(name: "name", email: "test@test.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      @new_user = User.new(name: "name", email: "TEST@TEST.com", password: "password", password_confirmation: "password")
      expect(@new_user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'is valid with valid attribute' do
      @user = User.new(name: "name", email: "test@test.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      User.authenticate_with_credentials("test@test.com", "password")
      expect(@user).to_not be nil
    end

    it 'is valid with an email with spaces around' do
      @user = User.new(name: "name", email: "test@test.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      User.authenticate_with_credentials(" test@test.com ", "password")
      expect(@user).to_not be nil
    end

    it 'is valid with an email with different cases' do
      @user = User.new(name: "name", email: "test@test.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      User.authenticate_with_credentials(" EXAMPLe@DOMAIN.CoM ", "password")
      expect(@user).to_not be nil
    end
  end

end