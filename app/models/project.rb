class Project < ActiveRecord::Base
    has_many :decisions
    has_many :tasks
    has_many :shareholders

    validates_presence_of :name
end
