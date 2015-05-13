class SupervisorController < AbstractServiceController
  def self.service_name
    'Experiment Supervisor'
  end

  def self.model_class
    ExperimentSupervisor
  end
end
