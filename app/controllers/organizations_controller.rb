class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :set_organization_redirect, only: [:show]

  def index
    if params[:tag].present?
      @organizations = Organization.tagged_with(params[:tag])
    else
      @organizations = Organization.all
    end
    @organizations = @organizations.order('title ASC').page(params[:page]).per(10)
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def edit
  end

  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        flash[:success] = t('messages.add_org')
        format.html { redirect_to @organization }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @organization.update(organization_params)
        flash[:success] = t('messages.edit_org')
        format.html { redirect_to @organization }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @organization.destroy
    respond_to do |format|
      flash[:success] = t('messages.delete_org')
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  private
    def set_organization_redirect
      @organization = Organization.friendly.find(params[:id])
      if request.path != organization_path(@organization)
        redirect_to @organization, status: :moved_permanently
      end
    end

    def set_organization
      @organization = Organization.friendly.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(:title, :description, :address, :phone, :email, :all_tags, :latitude, :longitude)
    end
end
