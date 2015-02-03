class ExperimentsController < AbstractServiceController
  def self.service_name
    'Experiment Manager'
  end

  def self.model_class
    ExperimentManager
  end
end
