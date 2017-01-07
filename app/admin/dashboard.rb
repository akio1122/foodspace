ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

  # Here is an example of a simple dashboard with columns and panels.
  #
   columns do
     column do
       panel "Recent Stories" do
         ul do
           Story.limit(5).map do |post|
             li link_to(post.title, admin_story_path(post))
           end
         end
       end
     end

     column do
       panel "Recent Events" do
         ul do
           Event.limit(5).map do |post|
             li link_to(post.title, admin_event_path(post))
           end
         end
       end
     end
   end
  end # content
end
