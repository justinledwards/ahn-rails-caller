class CallsController < ApplicationController
  def index
   require 'drb'
   adhearsion = DRbObject.new_with_uri 'druby://localhost:9050'
   puts "All post data"
   puts params.inspect
   if params[:call]  
   @call_count = params[:call][:call_count].to_i
   puts "Call Count"
   puts @call_count
   @to_number = params[:call][:to_number].to_i
   puts "Calling to"
   puts @to_number
   @from_number = params[:call][:from_number].to_i
   puts "With Caller ID"
   puts @from_number  
   adhearsion.make_call(@call_count, @to_number, @from_number)
   end
  end
end
