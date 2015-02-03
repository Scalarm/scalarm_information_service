class ExperimentsController < AbstractServiceController
  def self.name
    'Experiment Manager'
  end

  def self.model_class
    ExperimentManager
  end
end
