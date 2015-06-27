require_relative "Fecha"
require_relative "FileUtils"
require_relative "Noticia"
require_relative "NoticiaCorta"

class LecturaFichero

	RUTA = "newsCorpus"

	def noticias
		util = FileUtils.new
		nombres = util.list_files(RUTA)
		#En linux las carpetas por defecto 
		#generan estos 3 archivos
		nombres.delete(".")
		nombres.delete("..")
		nombres.delete(".directory")

		noticias = []
		for archivo in nombres
			txt = util.read_file(RUTA + "/" + archivo)
			noticias << self.noticiaDeString(txt)
		end
		return noticias
	end

	def noticiaDeString(n)
		texto_lineas = n.split("\n")
		titulo = texto_lineas[0]
		titulo.delete!("\r")
		fuenteFecha = texto_lineas[1]
		fuenteFecha.delete!("<")
		fuenteFecha.delete!(">")
		fuenteFecha.delete!("\r")
		fuenteFecha = fuenteFecha.split(",")
		fuente = fuenteFecha[0]
		fuenteFecha = fuenteFecha[1].split("/")
		fecha = Fecha.new(fuenteFecha[0],fuenteFecha[1],fuenteFecha[2])
		texto_lineas = texto_lineas.drop(2)
		texto_lineas = self.borrarSaltoLinea(texto_lineas)
		if texto_lineas.size == 2
			n = NoticiaCorta.new(titulo,fuente,fecha,[texto_lineas[0]],texto_lineas[1])
		else
			
			n = Noticia.new(titulo,fuente,fecha,texto_lineas)
		end
		return n
	end	

	def borrarSaltoLinea(l) #y caracteres raros de las lineas restantes
		l.delete("\r")
		for linea in l
			linea.chop! #delete!("\r")
		end
		return l
	end 

end	