require 'test_helper'
class Cheftest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "Legit Recipe", email: "legit@email.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname length should not be too long" do
   @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chefname length should not be too short" do
   @chef.chefname = "aa"
    assert_not @chef.valid?
  end
  
  test "email must be present" do
   @chef.email = " "
   assert_not @chef.valid?
  end
  
  test "email length should not be too long" do
   @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eau.au 2300+joe@monkey.com]
    valid_addresses.each do |va| 
      @chef.email = va 
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end
  
  test "email validates should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@ee+.com]
    invalid_addresses.each do |iva| 
      @chef.email = iva 
      assert_not @chef.valid?, '#{iva.inspect} should be invalid'
    end
  end
end