class PagesController < ApplicationController
  def home
  end

  def search
    @organizations = Organization.search(params[:search])
  end
end
