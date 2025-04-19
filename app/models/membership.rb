class Membership
  attr_reader :user

  # This is a virtual model that is used to store the membership information for
  # a user– it's not a real model in the database

  def initialize(user)
    @user = user
  end

  def total_hours
    @total_hours ||= ysws_projects.sum do |project|
      # handle if the Hours Spent is an array
      if project["Hours Spent"].is_a?(Array)
        project["Hours Spent"].first
      else
        project["Hours Spent"] || 0.0
      end
    end
  end

  def ysws_projects
    @ysws_projects ||= Airtable::ApprovedProject.find_by_user(@user)
  end

  def member_since
    @member_since ||= Airtable::HackClubber.member_since(@user)
  end

  def current_status
    case total_hours
    when 0...10
      :basic
    when 10...20
      :bronze
    when 20...30
      :silver
    else
      :gold
    end
  end
end
