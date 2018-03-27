class Picture < ActiveRecord::Base
  belongs_to :post
  has_attached_file :image,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/public/missing.png",
                    validate_media_type: false
  # validates_attachment_content_type :image,content_type: /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :image

end
