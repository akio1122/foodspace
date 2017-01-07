module PostData
  extend ActiveSupport::Concern

  included do
    def has_social?
      self.data['social'] && self.data['social'].values.reject(&:blank?).length > 0
    end

    def email
      self.data['email'] || ''
    end

    def website
      self.data['website'] || ''
    end

    def facebook
      self.data['social'] && self.data['social']['facebook']
    end

    def twitter
      self.data['social'] && self.data['social']['twitter']
    end

    def instagram
      self.data['social'] && self.data['social']['instagram']
    end
  end
end