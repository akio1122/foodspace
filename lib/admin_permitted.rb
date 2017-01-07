class AdminPermitted
  def self.general
    [:title, :slug, :status, :sort, :excerpt, :content, :publish, :data, :featured]
  end
  def self.social
    {data: [:email, :website, social: [:facebook, :twitter, :instagram]]}
  end
  def self.images
    [:image_targets => [], :image_targets_attributes => [:_destroy, :id, :sort, :image_attributes => [:_destroy, :id, :name, :alt, :file]]]
  end
  def self.tags
    [:diet_list,:taste_list,:country_list,:dish_list]
  end 
end