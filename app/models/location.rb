class Location < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :divisions

  def Location.get_by_name(name)
    loc = Location.find_by_name(name)
    unless loc
      loc = Location.create(:name=>name)
    end
    return loc
  end
end
