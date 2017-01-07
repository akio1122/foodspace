require 'uri'

class Image < ActiveRecord::Base
  has_many :image_targets, :dependent => :destroy
  has_many :events,  :through => :image_targets, :source => :target, :source_type => "Event"
  has_many :vendors, :through => :image_targets, :source => :target, :source_type => "Vendor"
  has_many :stories, :through => :image_targets, :source => :target, :source_type => "Story"

  has_attached_file :file, {
    :default_url => "/images/build/missing.jpg",
    :styles => Proc.new { |file| file.instance.styles }
  }

  validates_attachment :file, :presence => true,
    :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"] },
    :size => { :in => 0..2000.kilobytes }

  def dynamic_style_format_symbol
    URI.escape(@dynamic_style_format).to_sym
  end
  
  def styles
    unless @dynamic_style_format.blank?
      { dynamic_style_format_symbol => @dynamic_style_format }
    else
      {}
    end
  end

  def dynamic_file_url(format)
    return '' unless file.exists?
    @dynamic_style_format = format
    file.reprocess!(dynamic_style_format_symbol) unless file.exists?(dynamic_style_format_symbol)
    file.url(dynamic_style_format_symbol)
  end
end
