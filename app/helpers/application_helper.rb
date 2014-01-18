module ApplicationHelper

  def get_cash_difference_id(cash)
    if cash < 0
      "cash_difference_negative"
    else
      "cash_difference_positive"
    end
  end

end

