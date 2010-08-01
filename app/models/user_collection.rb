class UserCollection < ActiveRecord::Base
	has_and_belongs_to_many :decisions
	has_and_belongs_to_many :users
end
