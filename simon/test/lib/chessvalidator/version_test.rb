require_relative '../../test_helper'
 
describe ChessValidator do
 
  it "must be defined" do
    ChessValidator::VERSION.wont_be_nil
  end
 
end