# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'd82d2a39bf7b34747e151e941ccccb65'
  
  around_filter :select_db_connection

  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  protected
  
  def select_db_connection
    p "HI"
    name = (params.key? :person) ? params[:person][:name] : params[:name]
    p name
    case name
    when /^[A-Ma-m0-4]/
      ActiveRecord::Base.establish_connection :db_1
    when /^[N-Zn-z5-9]/
      ActiveRecord::Base.establish_connection :db_2
    else
      ActiveRecord::Base.establish_connection :development
    end
    yield
 
  ensure
    ActiveRecord::Base.connection.disconnect!
  end
end
