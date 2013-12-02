class League < ActiveRecord::Base
  attr_accessible :name, :sport
  has_many :divisions

  def self.sports
    League.all.map {|league| league.sport}.uniq
  end

  def sorted_divisions
    divisions = self.divisions
    sorted_divisions = {}
    divisions.each do |division|
      (sorted_divisions[division.start_date.wday] ||= []) << division
    end
    sorted_divisions
  end

end