class CallsController < ApplicationController
  def index
  #open connection to adhearsion via drb
   require 'drb'
   adhearsion = DRbObject.new_with_uri 'druby://localhost:9050'
   
   if params[:call]  
     @call_count = params[:call][:call_count].to_i
     @to_number = params[:call][:to_number].to_i
     @from_number = params[:call][:from_number].to_i
     adhearsion.make_call(@call_count, @to_number, @from_number)
   end
  end
end
