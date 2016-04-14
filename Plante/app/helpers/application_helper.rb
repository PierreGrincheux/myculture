module ApplicationHelper
	def header(text)
		content_for(:header){text.to_s}
	end

	def convert_date(date)
		return date.strftime("%d/%m/%Y %H:%M").to_s
	end

	def print_value(value, name)
		value ||= 'NA'
		return "#{value} #{VALUE_TYPES[:"#{name}"][2]}"
	end

	def print_value_name(name)
		return "#{VALUE_TYPES[:"#{name}"][0]}"
	end

	def print_unit(name)
		return "#{VALUE_TYPES[:"#{name}"][2]}"
	end

end
