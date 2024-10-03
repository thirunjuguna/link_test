class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def referrer
    request.referrer
  end

   def user_agent
    request.user_agent
   end

   def ip_address
     request.remote_ip
   end
end
