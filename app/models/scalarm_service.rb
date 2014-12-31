module ScalarmService
  def get_all_addresses
    self.all.map(&:address)
  end
end