class CommentsController < ApplicationController
  before_action :authenticate, only: [:create, :update, :destroy]

  def new
    @organization = Organization.find(params[:organization_id])
    @comment = Comment.new(:parent_id => params[:parent_id], :organization_id => params[:organization_id])
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @comment = @organization.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to organization_path(@organization) }
        format.js {}
      end
      return
    end
    flash[:success] = t('comments.info')
    redirect_to :back
  end

  def update
  end

  def destroy
    @comment = Comment.find(params[:id])
    @organization = Organization.find(params[:organization_id])
    if @comment.user == current_user
      @comment.delete
    elsif current_user && current_user.admin?
      @comment.delete
    else
      flash[:danger] = t('comments.warning')
      redirect_to :back
      return
    end
    redirect_to @organization
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end
end
