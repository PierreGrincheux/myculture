module ApplicationHelper
	def header(text)
		content_for(:header){text.to_s}
	end

	def convert_date(date)
		return date.strftime("%d/%m/%Y %H:%M:%S").to_s
	end

	def convert_date_short(date)
		return date.strftime("%d/%m/%Y").to_s
	end

	def convert_date_js(date)
		month = date[-1..-2].to_i
		return "#{date[0..1]} #{FRENCH_MONTHS["#{month}"]}"
	end

	def print_value(value, name)
		value ||= 'NA'
		return "#{value} #{VALUE_TYPES[:"#{name}"][2]}"
	end

	def print_value_name(name)
		case I18n.locale.to_s
			when "fr"
				return "#{VALUE_TYPES[:"#{name}"][0]}"
			when "en"
				return "#{VALUE_TYPES_EN[:"#{name}"][0]}"
		end
	end

	def print_unit(name)
		return "#{VALUE_TYPES[:"#{name}"][2]}"
	end

end
