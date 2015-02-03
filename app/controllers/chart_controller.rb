class ChartController < AbstractServiceController
  def self.service_name
    'Chart aaa Service'
  end

  def self.model_class
    ChartService
  end
end
