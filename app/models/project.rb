class Project < ActiveRecord::Base
  @@categories = {"site vitrine" => 1, "site de service" => 2, "e-commerce" => 3}
  has_many :images, :as => :attachable
  has_attached_file :logo, :styles => {:small => "37x", :big => "126x84>"}
  accepts_nested_attributes_for :images, :allow_destroy => true
  validates :category, :inclusion => {:in => @@categories.values, :message => "La catégorie n'est pas valide."}
  attr_accessible :title, :society, :societyType, :url, :description, :images_attributes, :category, :logo
  #logo
  def Project.categories 
    @@categories
  end
end
