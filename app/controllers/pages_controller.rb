class PagesController < ApplicationController
  include HighVoltage::StaticPage
  before_filter :set_navbar
def home
layout "landing_page"
end

def privacy
  
end

  private
 def set_navbar
  case params[:id]
  when "home"
    @disable_navbar = true 
  end
 end

end
