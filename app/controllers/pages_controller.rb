class PagesController < ApplicationController
  def home
    if current_user
  	  redirect_to ledgers_path
    end
  end

  def about
  end
end
