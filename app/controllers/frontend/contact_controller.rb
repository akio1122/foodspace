class Frontend::ContactController < ApplicationController
  layout "frontend"

  include ActiveadminSettings::Helpers

  before_filter :which_form

  def new
    @content_type = 'contact'
    @contact = Contact.new

    if params[:type] == "vendor_contact"
      @vendor = Vendor.available.find(params[:id]) || not_found
      @description = settings_value("Contact Vendor Single Description").value
      render "frontend/contact/vendor_new", layout: "script"
    end
  end
    
  def create
    @content_type = 'contact'
    @contact = Contact.new(params[:contact])

    @contact.request = request

    if @contact.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      
      if params[:type] == "vendor_contact"
        @vendor = Vendor.available.find(params[:id]) || not_found
        @description = settings_value("Contact Vendor Single Description").value
        render "frontend/contact/vendor_new", layout: "script"
      else
        render :new
      end
    else
      flash.now[:error] = 'Cannot send message.'

      if params[:type] == "vendor_contact"
        @vendor = Vendor.available.find(params[:id]) || not_found
        @description = settings_value("Contact Vendor Single Description").value
        render "frontend/contact/vendor_new", layout: "script"
      else
        render :new
      end
    end
    
  end

  def which_form

    type = params[:type]

    @formselect = [{
      :url   => url_for(params.slice(:type).merge(type: "booking")),
      :name  => "<em>Make a </em>booking enquiry<em></em>",
      :class => type == "booking" ? "active" : ""
    },{
      :url   => url_for(params.slice(:type).merge(type: "vendor")),
      :name  => "Join<em> food space</em> as a vendor",
      :class => type == "vendor" ? "active" : ""
    },{
      :url   => url_for(params.slice(:type).merge(type: "general")),
      :name  => "<em>Ask a </em>general question",
      :class => (type.nil? or type == "general") ? "active" : ""
    }];

    @which = ""
    @which = "booking" if type == "booking"
    @which = "vendor"  if type == "vendor"
    @which = "general" if !type or type == "general"

    @description = ""
    @description = settings_value("Contact Booking Description").value if type == "booking"
    @description = settings_value("Contact Vendor Description").value if type == "vendor"
    @description = settings_value("Contact General Description").value if !type or type == "general"

    # Meta data
    # set_meta_tags :title => settings_value("Home Title").value,
    #   :description => settings_value("Home Description").value,
    #   :twitter => {
    #     :title => settings_value("Home Title").value,
    #     :description => settings_value("Home Description").value
    #   },
    #   :og => {
    #     :title => settings_value("Home Title").value,
    #     :description => settings_value("Home Description").value
    #   }

  end
end
