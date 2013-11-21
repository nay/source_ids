# -- coding: utf-8

class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :users, :through => :user_groups

  accepts_source_ids_for :users
end
