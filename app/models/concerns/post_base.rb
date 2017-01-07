 module PostBase
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :title, use: [:slugged, :finders]
     
    acts_as_ordered_taggable_on :diets, :tastes, :countries, :dishes, :identifiers

    serialize :data, Hash

    # Validation
    validates :title, presence: true
    validates :slug, presence: true
    validates :status, presence: true
    validates :sort, presence: true
    validates :excerpt, presence: true
    validates :content, presence: true

    # scoped
    default_scope { order(sort: :desc, title: :asc) }

    scope :available, ->{ where(status: 'enabled') }
    scope :tags_filter, lambda { |tag_slugs| tagged_with(tag_slugs) }
    
    has_many :image_targets, :as => :target, :dependent => :destroy
    has_many :images, -> { uniq }, :through => :image_targets, :as => :target
    accepts_nested_attributes_for :images, allow_destroy: true
    accepts_nested_attributes_for :image_targets, allow_destroy: true
  end

  def image
    self.images.first || Image.first
  end

  def ordered_tags
    [].concat(taste_counts)
      .concat(dish_counts)
      .concat(country_counts)
      .concat(diet_counts)
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end