class PagesController < ApplicationController

  def home
    @organizations = Organization.all
  end

  def search
    if params[:search].present?
      @organizations = Organization.search(params[:search])
    else
      @organizations = Organization.all
    end
    @organizations = @organizations.page(params[:page]).per(5)
  end

end
