class Log < ApplicationRecord
  def start_time
    self.date
  end
end
