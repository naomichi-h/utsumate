class Log < ApplicationRecord
  def start_time
    self.date
  end

  def medicine?
    if self.medicine
      '飲めた'
    else
      '飲めなかった'
    end
  end

  def meal?
    if self.meal
      '摂れた'
    else
      '摂れなかった'
    end
  end

  def bathe?
    if self.bathe == :voluntary
      '自発的に入った'
    elsif self.bathe == :prompted
      '促されて入った'
    else
      '入らなかった'
    end
  end

  def go_out?
    if self.go_out == :alone
      '一人で外出した'
    elsif self.go_out == :with_someone
      '誰かと外出した'
    else
      '外出しなかった'
    end
  end

end
