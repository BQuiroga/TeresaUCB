class GroupsController < ApplicationController
  def index
    @user=current_user
    @belongs=@user.group_managers
    @groups=[]
    @belongs.each do |my_group|
      @group=my_group.group
      @groups=@groups+[@group]
    end
  end
  def create
    if Group.create(group_params)
      @grupo=Group.last
      GroupManager.create(@grupo.id,current_user.id)
    end
    redirect_to 'grupos/mis-grupos'
  end
  def group_params
    params.require(:group).permit(:name,:description)
  end
end
