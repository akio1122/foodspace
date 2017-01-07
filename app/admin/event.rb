ActiveAdmin.register Event do

  menu :priority => 3
  filter :title

  permit_params do
    permitted = []
    permitted << AdminPermitted.general
    permitted << AdminPermitted.social
    permitted << AdminPermitted.images
    permitted << AdminPermitted.tags
    permitted << [:location_id]
    permitted << [:vendor_ids => []]
    permitted << [:start, :end]
    permitted << [:event_dates_attributes => [:id, :_destroy, :start_date, :end_date, :start_time, :end_time]]
    permitted
  end

  index do
    column :title
    column :status
    column :sort
    actions
  end

  form :partial => "form"
  
end
