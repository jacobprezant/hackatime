class MembershipsController < ApplicationController
  before_action :set_membership, only: [ :show, :my_membership ]

  def index
    # Public page about membership perks
  end

  def my_membership
    render :show
  end

  def show
    # Public view of a specific user's membership
  end

  private

  def set_membership
    set_user
    puts @user.inspect
    @membership = Membership.new(@user)
  end

  def set_user
    @user = begin
      if params[:slack_uid] == "my" || params[:slack_uid].blank?
        current_user
      else
        User.find_by!(slack_uid: params[:slack_uid])
      end
    rescue
      nil
    end
  end
end
