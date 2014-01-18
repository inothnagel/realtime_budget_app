module AccountsHelper
	def behind_flag(account)
		account.ahead? ? '' : 'behind'
	end

	def ahead_or_behind_message(account)
		amount_string = number_to_currency(account.cash, unit: "R", separator: ",", delimiter: "", precision: 0)
	end
end
