class Frontend::EventController < ApplicationController
  layout "frontend"

  include ActiveadminSettings::Helpers

  def single

    @content_type = 'event'
    @event        = Event.available.find(params[:id]) || not_found
    @vendors      = @event.vendors

    @has_social = @event.has_social?

    @js_opts = {}
    @js_opts['marker']    = ActionController::Base.helpers.image_url("frontend/icons/map/marker.png")
    @js_opts['locations'] = [{
      :id        => @event.location.id,
      :title     => @event.location.title,
      :latitude  => @event.location.latitude,
      :longitude => @event.location.longitude
    }]
    
    @js_opts['events']    = [{
      :id          => @event.id,
      :title       => @event.title,
      :url         => @event.url,
      :start       => @event.event_dates.first.start,
      :end         => @event.event_dates.first.end,
      :location_id => @event.location_id
    }]

    # Set up meta
    set_meta_tags :title => @event.title,
      :description       => @event.excerpt,
      :canonical         => "#{request.protocol}#{request.host}/event/" + @event.slug,
      :twitter => {
        :title => @event.title,
        :description => @event.excerpt
      },
      :og => {
        :title => @event.title,
        :description => @event.excerpt
      }
  end

  def list
    @content_type = 'list'

    # Date filtering
    dateformat  = '%m-%y'
    @dateselect = []

    datenow   = Time.now.at_beginning_of_month
    datestart = datenow
    datestart = Time.strptime(params[:date], dateformat).at_beginning_of_month unless params[:date].nil?
    daterange = (datenow.to_i..(datenow + 5.month).at_end_of_month.to_i)

    # Bail if we are accessing some crazy/impossible date
    not_found unless (datestart.to_i.between?(daterange.begin.to_i,daterange.last.to_i))

    datelist = [(datestart - 1.month), datestart, datestart + 1.month, datestart + 2.month, datestart + 3.month, (datestart + 1.month)]
    datelist.each_with_index do |ds, ds_index|

      dsname = ds.strftime('%B %Y')
      dsname = 'Prev' if (ds_index == 0)
      dsname = 'Next' if (ds_index == datelist.size - 1)

      dsclass =  'selector'
      dsclass += ' active' if (ds == datestart)
      dsclass =  'prev'    if (ds_index == 0)
      dsclass =  'next'    if (ds_index == datelist.size - 1)

      dsurl = '/events/' + ds.strftime(dateformat)

      # If the link would go outside range..
      unless ds.to_i.between?(daterange.begin.to_i,daterange.last.to_i)
        dsclass += ' inactive'
        dsurl = ''
      end

      @dateselect << {
        :url   => dsurl,
        :name  => dsname,
        :class => dsclass
      }

    end

    @month = datestart.strftime('%B')

    # Tag filtering
    @tags = Event.all_tags
    @tags_filter = params[:filters] || []

    # All available events
    @event_dates = EventDate.future.joins(:event).merge(Event.available)
    # Filtered by Tags
    @event_dates = @event_dates.merge(Event.tags_filter(@tags_filter)) unless @tags_filter.empty?
    # Filtered by Date
    @event_dates = @event_dates.merge(EventDate.in_month(datestart))
    # Filtered by Page
    @event_dates = @event_dates.kpage(params[:page])

    # Meta data
    set_meta_tags :title => settings_value("Upcoming Events Title").value,
      :description => settings_value("Upcoming Events Description").value,
      :twitter => {
        :title => settings_value("Upcoming Events Title").value,
        :description => settings_value("Upcoming Events Description").value
      },
      :og => {
        :title => settings_value("Upcoming Events Title").value,
        :description => settings_value("Upcoming Events Description").value
      }

  end
end
