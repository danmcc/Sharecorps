class Vote < ActiveRecord::Base
	belongs_to :decision
	belongs_to :shareholder
end
