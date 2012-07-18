require "net/http"
require "model/node_manager"

class NodeManagerGuard

  def initialize(sleep_time)
    @sleep_time = sleep_time
  end

  def start_guard
    Thread.new do
      while true do
        sleep(@sleep_time)

        NodeManager.all.each do |node_manager|
          snm_server, snm_port = node_manager.uri.split(":")

          http = Net::HTTP.new(snm_server, snm_port.to_i)
          req = Net::HTTP::Get.new("/manager_status/experiment/1")
          # unregister node manager if not available
          begin
            http.request(req)
          rescue Exception => e
            puts "Unregistering NodeManager: #{node_manager.inspect}"
            node_manager.destroy
          end
        end
      end
    end
  end
end