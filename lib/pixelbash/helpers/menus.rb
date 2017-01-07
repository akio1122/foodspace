module Pixelbash::Helpers::Menus

  def main_menu
    @menu = []

    path = response.request.fullpath

    # Add Categories
    @categories = Category.all.limit(9)
    @categories.each do |c|
      cat_path = '/category/' + c.slug
      @menu << {
        :title => c.title,
        :href  => cat_path,
        :active => (path.include? cat_path) ? 'active' : ''
      }
    end

    # Add Videos
    @video = Post.videos.first
    if !@video.nil?
      video_path = '/video/' + @video.slug
      @menu << {
        :title => 'Videos',
        :href  => video_path,
        :active => (path.include? video_path) ? 'active' : ''
      } 
    end

    # Add Events
    @menu << {
      :title => 'Events',
      :href  => '/events',
      :active => (path.include? '/events') ? 'active' : ''
    }

    # Add Shop
    shop_active = ''
    if path.include? '/checkout' or  path.include? '/cart' or path.include? '/product' or  path.include? '/collection'
      shop_active = 'active'
    end
    @menu << {
      :title => 'Shop',
      :href  => '/products',
      :active => shop_active
    }

  end
  
end