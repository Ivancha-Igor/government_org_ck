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
  end

end
