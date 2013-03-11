# encoding: utf-8

class FooController < Adhearsion::CallController
  def run
    answer
    sleep 1
    #Replace testcall with your own asterisk recording
    play "testcall"
    hangup
  end
end

class DrbEndpoint
  def call_count
    logger.debug 'FOO'
    Adhearsion.active_calls.count
  end
# Replace SIPSERVICEHERE with your asterisk server's sip provider
  def make_call(call_count, to_number, from_number)
    call_count.times do 
     Adhearsion::OutboundCall.originate("SIP/#{to_number}@SIPSERVICEHERE", :from => "#{from_number}", :controller => FooController)
    end
  end
end


Adhearsion.config do |config|

  config.adhearsion_drb do |config|
   config.host = "127.0.0.1"
   config.port = "9050".to_i
   config.acl.allow = ["127.0.0.1"] # list of allowed IPs (optional)
   config.acl.deny = [] # list of denied IPs (optional)
   config.shared_object = DrbEndpoint.new
  end

  config.development do |dev|
    dev.platform.logging.level = :info
  end



#Fill one of these out and test adhearsion

  ##
  # Use with Rayo (eg Voxeo PRISM)
  #
  # config.punchblock.username = "" # Your XMPP JID for use with Rayo
  # config.punchblock.password = "" # Your XMPP password

  ##
  # Use with Asterisk
  #
  # config.punchblock.platform = :asterisk # Use Asterisk
  # config.punchblock.username = "" # Your AMI username
  # config.punchblock.password = "" # Your AMI password
  # config.punchblock.host = "127.0.0.1" # Your AMI host

  ##
  # Use with FreeSWITCH
  #
  # config.punchblock.platform = :freeswitch # Use FreeSWITCH
  # config.punchblock.password = "" # Your Inbound EventSocket password
  # config.punchblock.host = "127.0.0.1" # Your IES host
end

Adhearsion::Events.draw do


end

#Only doing outbound so not worried about this
Adhearsion.router do
  route 'default', SimonGame
end
