# encoding: utf-8

class FooController < Adhearsion::CallController
  def run
    answer
    sleep 1
    play "testcall"
    hangup
  end
end

class DrbEndpoint
  def call_count
    logger.debug 'FOO'
    Adhearsion.active_calls.count
  end

  def make_call(call_count, to_number, from_number)
    call_count.times do 
     Adhearsion::OutboundCall.originate("SIP/#{to_number}@192.168.77.130", :from => "#{from_number}", :controller => FooController)
    end
  end
end


Adhearsion.config do |config|

  # Centralized way to specify any Adhearsion platform or plugin configuration
  # - Execute rake config:show to view the active configuration values
  #
  # To update a plugin configuration you can write either:
  #
  #    * Option 1
  #        Adhearsion.config.<plugin-name> do |config|
  #          config.<key> = <value>
  #        end
  #
  #    * Option 2
  #        Adhearsion.config do |config|
  #          config.<plugin-name>.<key> = <value>
  #        end
  config.adhearsion_drb do |config|
   config.host = "127.0.0.1"
   config.port = "9050".to_i
   config.acl.allow = ["127.0.0.1"] # list of allowed IPs (optional)
   config.acl.deny = [] # list of denied IPs (optional)
   config.shared_object = DrbEndpoint.new
  end

  config.development do |dev|
    dev.platform.logging.level = :debug
  end




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
   config.punchblock.platform = :asterisk # Use Asterisk
   config.punchblock.username = "adhearsion" # Your AMI username
   config.punchblock.password = "n0way0ut" # Your AMI password
   config.punchblock.host = "127.0.0.1" # Your AMI host

  ##
  # Use with FreeSWITCH
  #
  # config.punchblock.platform = :freeswitch # Use FreeSWITCH
  # config.punchblock.password = "" # Your Inbound EventSocket password
  # config.punchblock.host = "127.0.0.1" # Your IES host
end

Adhearsion::Events.draw do

  # Register global handlers for events
  #
  # eg. Handling Punchblock events
  # punchblock do |event|
  #   ...
  # end
  #
  # eg Handling PeerStatus AMI events
  # ami :name => 'PeerStatus' do |event|
  #   ...
  # end
  #
end

Adhearsion.router do

  #
  # Specify your call routes, directing calls with particular attributes to a controller
  #

  route 'default', SimonGame
end
