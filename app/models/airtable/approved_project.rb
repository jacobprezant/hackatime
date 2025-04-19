Airrecord.api_key = ENV["YSWS_AIRTABLE_API_KEY"]
class Airtable::ApprovedProject < Airrecord::Table
  self.base_key = "app3A5kJwYqxMLOgh"
  self.table_name = "Approved Projects"

  def self.find_by_slack_uid(slack_uid)
    user = User.find_by(slack_uid: slack_uid)
    return [] if user.nil?
    find_by_user(user)
  end

  def self.find_by_user(user)
    emails = EmailAddress.where(user: user).pluck(:email)
    puts "emails: #{emails}"
    if emails.none?
      []
    elsif emails.length == 1
      puts "searching for #{emails.first}"
      result = self.all(filter: "{Email} = \"#{emails.first}\"")
      puts "result: #{result}"
      result
    else
      self.all(filter: "OR(" + emails.map { |email| "Email = \"#{email}\"" }.join(",") + ")")
    end
  end
end
