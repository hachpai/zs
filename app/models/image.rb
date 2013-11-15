##http://everydayrails.com/2011/09/07/rails-contact-form.html
class Image < ActiveRecord::Base

  belongs_to :attachable, :polymorphic => true
  #has_attached_file :asset, :styles => {:small => "37x", :thumbnail =>  "74x", :crop => "460x322>", :big => "360x", :huge => "642x"}, :processors => [:cropper]
  has_attached_file :asset, :styles => {:small => "37x", :thumbnail =>  "74x", :crop => "460x322>", :big => "360x", :huge => "642x"}
  attr_accessible :asset, :asset_file_name
  validates_attachment_content_type :asset, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'], :message => "Le fichier fourni n'est pas une image."  
  
  def cropping?
     !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?   
  end
  
  def crop_image
    image.reprocess!
  end
  
  def image_geometry(style = :original)
    puts "Just arrived here! Nothing to signal"
    @geometry ||= {}
    image_path = (asset.options[:storage] == :s3) ?   asset.url(style) : asset.path(style)
    puts "Hello, logs!#{image_path}"
    @geometry[style] ||= Paperclip::Geometry.from_file(image_path)
  end
end

