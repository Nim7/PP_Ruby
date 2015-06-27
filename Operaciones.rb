require_relative "Fecha"
require_relative "Noticia"
require_relative "NoticiaCorta"
require_relative "LecturaFichero"
require_relative "LCS"

class Operaciones
#las operaciones devuelven una lista de noticias, asi se pueden reutilizar para otros metodos

	def listaFuentes(noticias)
		fuentes = []
		for noticia in noticias
			fuentes << noticia.fuente
		end
		return fuentes.uniq
	end
	def listaNoticiasFuente(noticias, fuente)
		lNoticias = []
		for noticia in noticias
			if noticia.eqFuente(fuente)
				lNoticias << noticia
			end	
		end	
		return lNoticias
	end
	
	def listaNoticiasFecha(noticias, fecha)
		lNoticias = []
		for noticia in noticias
			if noticia.eqFecha(fecha)
				lNoticias << noticia
			end	
		end	
		return lNoticias
	end

	def listaNoticiasErrores(noticias)
		lNoticias = []
		for noticia in noticias
			if noticia.tieneError
				lNoticias << noticia
			end	
		end	
		return lNoticias
	end
	def listaNoticiasAmpliables(noticias)
		lNoticias = []
		for noticia in noticias
			begin #bloque try/catch
				if (noticia.ampliable)
					lNoticias << noticia
				end
			rescue
			end #end bloque
		end
		return lNoticias	
	end
	def listaNoticiasNParrafos(noticias, numParrafos)
		lNoticias = []
		for noticia in noticias
			if noticia.eqHigParrafos(numParrafos)
				lNoticias << noticia
			end	
		end	
		return lNoticias
	end
	def listaNoticiasCadena(noticias, cad)
		lNoticias = []
		for noticia in noticias
			#contiene la cadena en el titulo normal o corregido
			if noticia.contieneCad(cad) 
				lNoticias << noticia
			end	
		end	
		return lNoticias
	end 
	def agruparNoticias(noticias)
		salida = []
		while (noticias.length > 0)
			aux = self.agruparNoticiasAux(noticias)
			salida << aux
			#borramos las noticias ya comprobadas
			for n in aux
				noticias.delete(n)
			end 
		end
		#devolvemos un [[Noticia1,Noticia2],[Noticiax, .. , ..], [..], ..]
		return salida
	end
	def agruparNoticiasAux(noticias)
		#Coge la 1º noticia del Array y la compara con el resto
		s = LCS.new
		notic = noticias
		noticia = notic.shift
		str = self.listaStringToSring(noticia.palabrasClaveTitulo)
		salida = []
		salida << noticia
		for n in notic
			#comparo solo el titulos de las noticias, ya que al existir noticas cortas
			#si tenemos en cuenta el contenido se va mucho de rango y no tienen sentido 
			#las agrupaciones que se forman
			if s.similars(str, self.listaStringToSring(n.palabrasClaveTitulo),27)
				#si son similares, las devuelve
				salida << n
			end
		end
		#devolvemos [Noticia1,Noticia2, ....]
		return salida
	end	

	def listaStringToSring(lista)
		#trasformar a string para usar similars
		salida = ""
		for cad in lista
			salida << cad
		end
		return salida
	end	
	def fechasIguales(noticias)
		n = noticias
		noticia = n[0]
		iguales = false
		for aux in n
			if aux.eqFechaNoticia(noticia) && aux!=noticia
				iguales = true
			end
		end
		return iguales
	end

end