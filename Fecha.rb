class Fecha
	include Comparable

	def initialize (dia, mes, year)
		@dia = dia
		@mes = mes
		@year = year
	end
	def to_s
		"#{@dia}/#{@mes}/#{@year}"
	end	
	def <=>(f)
		return (f.year == self.year && f.mes == self.mes && self.dia <=> f.dia) || (self.year == f.year && self.mes <=> f.mes) || (self.year <=> f.year)
	end

	attr_reader :dia, :mes, :year

end	