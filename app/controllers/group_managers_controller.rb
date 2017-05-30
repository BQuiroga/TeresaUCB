class GroupManagersController < ApplicationController
  def abandonar
    @group=GroupManager.where(group_id:params[:id],user_id:current_user.id)
    redirect_to '/grupos/mis_grupos'
  end
end
