class HomesController < ApplicationController
  def index
    if logged_in?
      redirect_to meals_path
    else
      respond_to do |format|
        format.js
        format.html # index.html.erb
        format.xml  { render :xml => @meals }
      end
    end
  end
end
