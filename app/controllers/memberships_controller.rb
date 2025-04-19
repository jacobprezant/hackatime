class MembershipsController < ApplicationController
  before_action :set_membership, only: [ :show ]

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
    @membership = Membership.new(set_user)
  end

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
end
