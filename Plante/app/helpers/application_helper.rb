module ApplicationHelper
	def header(text)
		content_for(:header){text.to_s}
	end

	def convert_date(date)
		return date.strftime("%d/%m/%Y %H:%M").to_s
	end
end
