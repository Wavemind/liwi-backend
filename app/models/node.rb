# Every composant of an algorithm
class Node < ApplicationRecord

  validates_presence_of :label
  validates_presence_of :description
  validates_presence_of :reference

end
