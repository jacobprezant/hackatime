class MembershipsController < ApplicationController
  before_action :authenticate_user!, only: [ :my_membership ]

  def index
    # Public page about membership perks
  end

  def my_membership
    @user = current_user
    render :show
  end

  def show
    # Public view of a specific user's membership
    @user = User.find_by!(slack_uid: params[:slack_uid])
    @ysws_projects = get_ysws_projects
  end

  private

  def set_user
    @user = begin
      if params[:slack_uid] == "my"
        current_user
      else
        User.find_by!(slack_uid: params[:slack_uid])
      end
    rescue
      nil
    end
  end

  def get_ysws_projects
    return [] if @user.nil?
    Airtable::ApprovedProject.find_by_user(@user)
  end
end
