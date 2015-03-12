class CommentsController < ApplicationController
  before_action :authenticate, only: [:create, :update, :destroy]

  def new
    @organization = Organization.find(params[:organization_id])
    @comment = Comment.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @comment = @organization.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to organization_path(@organization), notice: 'Ваш комментарий успешно сохранен' }
      end
    end
  end

  def update
  end

  def destroy
    @comment = Comment.find(params[:id])
    @organization = Organization.find(params[:organization_id])
    if @comment.user == current_user
      @comment.delete
    end
    redirect_to @organization
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
