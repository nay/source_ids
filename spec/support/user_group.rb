# -- coding: utf-8

class UserGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end
