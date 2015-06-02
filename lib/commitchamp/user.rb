module Commitchamp
  class User < ActiveRecord::Base
    has_many :contributions
    has_many :repos, through: :contributions
  end

  class Repo < ActiveRecord::Base
    has_many :contributions
    Has many :users, through: :contributions
  end

  class Contribution < ActiveRecord::Base
    belongs_to :users
    belongs_to :repos
  end
end