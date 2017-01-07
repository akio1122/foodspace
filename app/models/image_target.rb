class ImageTarget < ActiveRecord::Base
  belongs_to :image
  belongs_to :target, polymorphic: true
  accepts_nested_attributes_for :image, 
                                :reject_if => :all_blank


  default_scope { order(sort: :asc) }

end
