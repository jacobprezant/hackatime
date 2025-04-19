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
    start_date = Date.new(2025, 3, 19)
    if emails.none?
      []
    elsif emails.length == 1
      puts "searching for #{emails.first}"
      filter = "AND({Email} = '#{emails.first}', {Approved At} >= '#{start_date.strftime("%d/%m/%Y")}')"
      puts "filter: #{filter}"
      result = self.all(filter: filter)
      puts "result: #{result}"
      result
    else
      self.all(filter: "OR(" + emails.map { |email| "Email = \"#{email}\"" }.join(",") + ")")
    end
  end
end
