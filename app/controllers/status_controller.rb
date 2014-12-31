require 'xmlsimple'
require 'restclient'

class StatusController < ApplicationController
  def status
    render nothing: true, status: :ok
  end

  def scalarm_status
    em_states = collect_service_states(ExperimentManager)
    storage_states = collect_service_states(StorageManager)

    status = 'ok'
    message = ''

    if any_service_in_state?('failed', em_states, storage_states)
      status = 'failed'
      message = 'One or more service failed. Please check service details.'
    elsif any_service_in_state?('warning', em_states, storage_states)
        status = 'warning'
        message = 'One or more service has warnings. Please check service details.'
    end

    # response status for nagios probe: ok, failed, warning
    data = {
        date: Time.now,
        status: status, message: message
    }

    add_service_states(data, em_states, 'experiment_manager')
    add_service_states(data, storage_states, 'storage_manager')

    respond_to do |format|
      format.html do
        render text: JSON.pretty_generate(data)
                         .gsub("\n", '<br/>')
                         .gsub(' ', '&nbsp;'),
               status: :ok
      end
      format.json do
        render json: data, status: :ok
      end
      format.xml do
        render xml: convert_status_to_xml(data), status: :ok
      end
    end
  end

  def convert_status_to_xml(data)
    XmlSimple.xml_out(data,
                      AttrPrefix: false,
                      RootName: 'healthdata',
                      ContentKey: :content)
  end


  def any_service_in_state?(for_status, *service_states)
    service_states.any? do |states_set|
      states_set.any? {|s| s[:status] == for_status}
    end
  end

  def collect_service_states(service_class)
    service_class.get_all_addresses.collect do |address|
      query_status_all(address)
    end
  end

  def add_service_states(data, states, name)
    counter = 0
    states.each do |s|
      data["#{name}#{counter+=1}".to_sym] = [s]
    end
  end

  def query_status_all(service_address, scheme='https')
    begin
      resp = RestClient.get "#{scheme}://#{service_address}/status",
                            params: { tests: ['database'] },
                            content_type: :json, accept: :json
    rescue RestClient::Exception => e
      resp = e.response
    end

    begin
      json_resp = JSON.parse(resp)
    rescue
      return {
          status: 'failed',
          content: "Invalid response (#{resp.respond_to?(:code) ? resp.code : 'none'}): \"#{resp}\""
      }
    end

    if resp.code == 200
      result = {
          status: ((json_resp['status'] == 'ok') and 'ok' or 'warning')
      }
      result[:content] = json_resp['message'] if json_resp['message']
    else
      result = {
          status: 'failed'
      }
      result[:content] = (if json_resp['message']
                           "Code #{resp.code}, message: #{json_resp['message']}"
                         else
                           "Error withoud message (code #{resp.code}): \"#{resp}\""
                         end)
    end

    result
  end

  private :query_status_all, :add_service_states, :any_service_in_state?,
          :collect_service_states, :convert_status_to_xml
end
