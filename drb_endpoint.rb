# encoding: utf-8

class OutboundTestController < Adhearsion::CallController
  def run
	answer
	record :async => true do |event|
      		logger.info "Async recording saved to #{event.recording.uri}"
    	end
	play "testcall"
        hangup
  end
end  
