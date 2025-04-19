Airrecord.api_key = ENV["YSWS_AIRTABLE_API_KEY"]

class Airtable::HackClubber < Airrecord::Table
  self.base_key = "app3A5kJwYqxMLOgh"
  self.table_name = "Synced - Hack Clubbers"

  def self.member_since(user)
    Rails.cache.fetch("hack_clubber_member_since_#{user.id}", expires_in: 1.hour) do
      user_emails = EmailAddress.where(user: user).pluck(:email)
      return nil if user_emails.empty?
      users = self.find_by_email(user_emails)
      return nil if users.empty?
      start_date = users.map { |user| user["First Engagement At"] }.min
      Date.parse(start_date)
    end
  end

  def self.find_by_email(emails)
    if emails.length == 1
      self.all(filter: "{Email} = \"#{emails.first}\"")
    else
      self.all(filter: "OR(" + emails.map { |email| "{Email} = \"#{email}\"" }.join(",") + ")")
    end
  end
end
