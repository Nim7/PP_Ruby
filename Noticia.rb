require_relative "Fecha"
require_relative "FileUtils"

class Noticia
	include Comparable

	#Inicializar el Hash y rellenarlo desde fichero
	@@normalizacion = Hash.new
	utils = FileUtils.new
	fcontent = utils.read_file('normalization.txt')
	cad1 = fcontent.split("\n") #separar por salto de linea
	for cad2 in cad1
		cad3 = cad2.split(" --- ")#por cada una de las nuevas lineas, separar por ese string
		@@normalizacion[cad3[0].to_s] = cad3[1].delete("\r").to_s #introducir en el Hash
	end
	#Iniciar el Array y rellenarlo desde fichero
	@@stopwords = Array.new
	fcontent = utils.read_file('stopwords.txt')
	cad1 = fcontent.split("\n") #separar por salto de linea
	for cad2 in cad1
		cad3 = cad2.delete("\r")
		@@stopwords << cad3 #introducir en el Array
	end
	

	def initialize (titulo, fuente, fecha, contenido)
		@titulo=titulo
		@fuente=fuente
		@fecha=fecha
		@contenido=contenido
	end

	def to_s
		aux = self.normalizarTitulo + "\n" + @fuente + " - " + @fecha.to_s + "\n"
		for aux1 in @contenido
			aux << aux1
			aux << "\n"
		end
		return aux
	end

	def normalizarTitulo
		nTitulo = ""
		titulo = @titulo
		tituloDiv = titulo.split #dividir en palabras
		tituloDiv.each do | palabra |
			aux = @@normalizacion[palabra] 
			if  aux == nil #si el Hash devuelve nil la palabra esta bien
				nTitulo = nTitulo + palabra + " "				
			else #si no, devuelve el valor al cual hay que borrarle el "\r" del final
				palabraEntera = aux.delete("\r")
				nTitulo += palabraEntera + " "
			end
		end
		nTitulo = nTitulo.rstrip
		return nTitulo		
	end

	def titulos
		"Original:  " + @titulo + "\n" + "Correjido: " + self.normalizarTitulo + "\n"
	end

	def eqFuente(fuen)
		@fuente == fuen
	end

	def eqFecha(fech)
		@fecha == fech
	end	
	def eqFechaNoticia(noticia)
		@fecha == noticia.fecha
	end	
	def tieneError
		@titulo != self.normalizarTitulo
	end
	def eqHigParrafos(numParrafos)
		@contenido.size >= numParrafos
	end
	def contieneCad(cad)
		(@titulo.include? cad) || (self.normalizarTitulo.include? cad)
	end
	def entidades
		#como las palabras clave ya coprueban los stowords, solo tenemos que coger de estas
		#las que empiezan por mayuscula
		palabras = self.palabrasClave 
		ent = []
		for cad in palabras
			if (cad[0..0] =~ /[A-Z]/)
				ent << cad
			end 
		end 

		return ent.uniq
	end
	def entidadesTitulo
		palabras = self.palabrasClaveTitulo 
		ent = []
		for cad in palabras
			if (cad[0..0] =~ /[A-Z]/)
				ent << cad
			end 
		end 

		return ent.uniq
	end
	def palabrasClaveTitulo
		cad = self.normalizarTitulo
		ent = []
		cad2 = cad.split #dividir por el espacio
			#Compara las palabras en busca de las que empiecen por mayusculas 
		for cad3 in cad2
			cad3 = cad3.delete "," "." ")" "(" "-" #borrar algunos caracteres de puntuacion
			if !(@@stopwords.include? cad3.downcase)	
				#Comprueba si es un stopword en minuscula	
				ent << cad3
			end
			 	 
		end

		return ent.uniq
	end

	def palabrasClave
		cont = @contenido #guardar el cotenido
		cont.unshift(self.normalizarTitulo) #add titulo al contenido
		ent = []
		for cad in cont
			cad2 = cad.split #dividir por el espacio
			#Compara las palabras en busca de las que empiecen por mayusculas 
			for cad3 in cad2
				cad3 = cad3.delete "," "." ")" "(" "-" #borrar algunos caracteres de puntuacion
				if !(@@stopwords.include? cad3.downcase)	
					#Comprueba si es un stopword en minuscula	
					ent << cad3
				end
				 	 
			end 
		end 

		return ent.uniq
	end

	def <=>(n2)
		if self.fecha == n2.fecha
			return self.titulo <=> n2.titulo
		else
			return self.fecha <=> n2.fecha
		end
	end
	
	attr_reader :titulo, :fecha, :fuente, :contenido

end