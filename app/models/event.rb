class Event < ActiveRecord::Base
  include PostBase
  include PostData

  belongs_to :location

  has_many :event_vendors
  has_many :vendors, :through => :event_vendors
  has_many :event_dates

  accepts_nested_attributes_for :event_dates, allow_destroy: true

  scope :featured, ->{ where(featured: true) }

  def url
    @url = '/event/' + self.slug
  end
end
