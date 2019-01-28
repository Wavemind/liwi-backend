# Every composant of an algorithm
class Node < ApplicationRecord

  validates_presence_of :label
  validates_presence_of :reference

  validates_uniqueness_of :reference
end
