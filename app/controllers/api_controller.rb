class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token


   private

   # authenticate_or_request_with_http_basic implements basic HTTP authentication, which ensures HTTP requests are accompanied by a valid username and password

   def authenticated?
      authenticate_or_request_with_http_basic {|full_name, password| User.where( full_name: full_name, password: password).present? }
   end

end
