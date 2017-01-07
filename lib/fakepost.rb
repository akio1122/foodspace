class Fakepost
  def generate(override={})

    defaults = {
      'img' => {
        'size' => [320,215]
      },
      'title' => {
        'length' => 20
      },
      'excerpt' => {
        'length' => 20
      }
    }

    settings = defaults.merge(override)

    @post = {
       'image'  => {
        'src'    => '', #Faker::imageUrl($settings['img']['size'][0],$settings['img']['size'][1], 'city', false).'?'.rand(0,50),
        'width'  => settings['img']['size'][0],
        'height' => settings['img']['size'][1]
      },
      'category' => Faker::Lorem.word,
      'title'    => Faker::Lorem.words(settings['title']['length']),
      'date'     => '12.05.1988',
      'author'   => Faker::Name.name,
      'excerpt'  => Faker::Lorem.words(settings['excerpt']['length']),
      'content'  => Faker::Lorem.words(2000),
      'time'     => Faker::Number.number(2),
      'url'      => '/post',
      'video'    => {
        'src'     => '//player.vimeo.com/video/#{@video_id}?autoplay=0&amp;loop=1',
        'caption' => Faker::Lorem.words(200)
      }
    }
  end
end