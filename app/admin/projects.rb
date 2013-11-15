ActiveAdmin.register Project do

  controller do
    
    #after_filter :reprocess_image, :if => :cropping?, :only => :update
    
    def cropping?
      @project.cropping?
    end
    
    def reprocess_image
      @project.crop_image
    end
    
    def create
      @project = Project.new(params[:project])
      if @project.save
        flash[:notice] = I18n.t("project_added")
        redirect_to admin_project_path(@project)
      else
        render :action => 'new'
      end
    end
    
    def update
      @objet = Objet.find(params[:id])
      if @objet.update_attributes(params[:project])
        flash[:notice] = I18n.t("project_updated")

        redirect_to admin_project_path(@project)

      else
        render :action => 'edit'
      end
    end
  end
  
  index do
    column :title
    column :image do |project|
      image_tag project.logo.url(:small) 
    end
    default_actions
  end
  filter :category, :as => :select, :collection => proc { Project.categories }

  form :html => {:multipart => true} do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Projet" do
      f.input :title, :label => I18n.t("title")
      f.input :description, :label => I18n.t("description")
      f.input :url, :label => I18n.t("url")
      f.input :society, :label => I18n.t("society")
      f.input :societyType, :label => I18n.t("society_type")
      f.input :category, :as => "select", :collection => Project.categories, :label => I18n.t("category")
      f.input :logo
      f.has_many :images do |file|
        file.input :asset, :as => :file, :hint => file.object.asset.file? ?  f.template.image_tag(file.object.asset.url(:thumbnail)) : f.template.content_tag(:span, I18n.t("no_image_yet")), :input_html => {:name => 'project[images_attributes][][asset]'}
      end
    end
    f.actions
  end
end  

