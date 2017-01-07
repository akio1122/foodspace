module Pixelbash::Helpers::Images
  def image_sizes
    {
      :next_event   => '540x350#',
      :block => {
        :event  => '320x220#',
        :search => '320x220#',
        :story  => '320x220#',
        :vendor => '373x180#',
      },
      :gallery => {
        :story => '1040#x400#',
        :vendor => '960x470#'
      }
    }
  end
end