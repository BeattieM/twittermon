# Active Record base model
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
