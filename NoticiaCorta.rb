require_relative "Noticia"
require_relative "Fecha"

class NoticiaCorta < Noticia
	
	def initialize (titulo, fuente, fecha, contenido, enlace)
		super(titulo, fuente, fecha, contenido)
		@enlace = enlace
	end

	def to_s
		s = super.split("\n") #recojo el to_s del padre y lo divido por "\n" para ponerle "(R)"
		return s[0] + "  (R)\n" + s[1] + "\n" + s[2] + "\n" + @enlace 		
	end
	def ampliable
		#No guarda bien algunos string, por tanto si "@enlace" es "[ ]" como 
		#maximo su longitud es 3 y tendra enlace si es mayor 
		@enlace.length > 3	
	end	

	attr_reader :enlace

end