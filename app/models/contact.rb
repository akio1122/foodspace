class Contact < MailForm::Base
  attribute :name,          :validate => true
  attribute :email,         :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :phone,         :validate => false

  attribute :booking_type,  :validate => :booking_form?
  attribute :booking_date,  :validate => :booking_form?
  attribute :booking_count, :validate => :booking_form?

  attribute :vendor_id,     :validate => :vendor_contact_form?
  attribute :vendor_name,   :validate => :vendor_contact_form?

  attribute :vendor_new_name, :validate => :vendor_form?
  attribute :vendor_city,     :validate => :vendor_form?
  attribute :vendor_extra,    :validate => false

  attribute :message,       :validate => true
  attribute :type,          :validate => ["general", "vendor", "booking", "vendor_contact"]

  attribute :nickname,  :captcha  => true

  # Validate booking
  def booking_form?
    if type == "booking"
      self.errors.add(:booking_type, "Please select a booking type")  if booking_type == ""
      self.errors.add(:booking_date, "Please select a booking date")  if booking_date == ""
      self.errors.add(:booking_count, "Please enter a number of attendants") if booking_count == ""
    end
  end

  # Validate vendor
  def vendor_form?
    if type == "vendor"
      self.errors.add(:vendor_city, "Please enter a city")  if vendor_city == ""
      self.errors.add(:vendor_new_name, "Please write your vendor name")  if vendor_new_name == ""
    end
  end

  # Validate vendor contact form ID
  def vendor_contact_form?
    if type == "vendor_contact"
      not_found  if vendor_id == ""
    end
  end

  # Declare the e-mail headers. It accepts anything the mail method in ActionMailer accepts.
  def headers
    # Set destination email based on booking type
    cc = ""

    case type
    when "general"
      to = "feedme@foodspace.co.nz"
    when "vendor"
      to = "vendors@foodspace.co.nz"
    when "vendor_contact"
      # Get the vendors email address
      vendor = Vendor.available.find(vendor_id)
      to = (vendor.email.nil?) ? "feedme@foodspace.co.nz" : vendor.email
      cc = (vendor.email.nil?) ? "" : "feedme@foodspace.co.nz"
    when "booking"
      to = "events@foodspace.co.nz"
    else
      to = "feedme@foodspace.co.nz"
    end

    # Send message
    {
      :subject => "Foodspace Contact Form",
      :to      => to,
      :cc      => cc,
      :from    => %("#{name}" <#{email}>)
    }
  end
end