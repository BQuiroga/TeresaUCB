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
      GroupManager.create(group_id:@grupo.id,user_id:current_user.id)
    end
    redirect_to '/grupos/mis_grupos'
  end
  def unirme
    @group_id=params[:id]
    GroupManager.create(group_id:@group_id,user_id:current_user.id)
    redirect_to '/grupos/mis_grupos'
  end
  def all
    @grupos=Group.all
  end
  def abandonar
    @group=GroupManager.where(group_id:params[:id],user_id:current_user.id)
    @group=@group.first
    @group.destroy
    if current_user.is_my_group(params[:id])
      Group.find(params[:id]).destroy
    end
    redirect_to '/grupos/mis_grupos'
  end
  def group_params
    params.require(:group).permit(:name,:description,:user_id)
  end
end
