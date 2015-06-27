#encoding: utf-8
require_relative "Fecha"
require_relative "LecturaFichero"
require_relative "Operaciones"
class Main
	def titulosNormalizadosFuente(noticias)
		o = Operaciones.new
		aux = o.listaFuentes(noticias)
		for aux1 in aux
			puts "--#{aux1}--"
			puts "-------------"
			aux1 = o.listaNoticiasFuente(noticias,aux1)
			aux1 = o.listaNoticiasErrores(aux1)
			for aux2 in aux1
				puts aux2.titulos
			end
			puts "-------------"
		end
		puts ""
	end
	def titulosPorFuente(noticias, fuente)
		o = Operaciones.new
		aux = o.listaNoticiasFuente(noticias,fuente)
		for aux1 in aux
			#divido el to_s en partes por el salto de linea, me quedo solo con el titulo
			aux2 = aux1.to_s.split("\n") 
			puts aux2[0]
		end
		puts ""
	end
	def titulosPorFuenteFecha(noticias, fuente, fecha)
		o = Operaciones.new
		aux = fecha.split("/")
		aux1 = o.listaNoticiasFuente(noticias,fuente)
		fecha = Fecha.new(aux[0],aux[1],aux[2])
		aux1 = o.listaNoticiasFecha(aux1,fecha)
		for aux2 in aux1
			#divido el to_s en partes por el salto de linea, me quedo solo con el titulo
			aux3 = aux2.to_s.split("\n") 
			puts aux3[0]
		end
		puts ""
	end
	def titulosPorFuenteAmpliables(noticias, fuente)
		o = Operaciones.new
		aux = o.listaNoticiasFuente(noticias,fuente)
		aux = o.listaNoticiasAmpliables(aux)
		for aux2 in aux
			#divido el to_s en partes por el salto de linea, me quedo solo con el titulo
			aux3 = aux2.to_s.split("\n") 
			puts aux3[0]
		end
		puts ""
	end
	def noticiasPorParrafos(noticias, n)
		o = Operaciones.new
		aux = o.listaNoticiasNParrafos(noticias,n.to_i)
		for aux2 in aux
			#divido el to_s en partes por el salto de linea, me quedo solo con el titulo
			aux3 = aux2.to_s.split("\n") 
			puts aux3[0]
		end
		puts ""
	end
	def noticiasPorCadena(noticias, cad)
		o = Operaciones.new
		aux = o.listaNoticiasCadena(noticias,cad)
		puts "---------"
		for aux1 in aux
			puts aux1
			puts "---------"
		end
		puts ""
	end
	def noticiasOrdendas(noticias)
		aux = noticias.sort
		for aux2 in aux
			#divido el to_s en partes por el salto de linea
			aux3 = aux2.to_s.split("\n") 
			puts aux3[0]
			puts aux3[1]
			puts "---------"
		end
		puts ""
	end
	def entidadesPorNoticiaFuente(noticias, fuente)
		o = Operaciones.new
		aux = o.listaNoticiasFuente(noticias,fuente)
		for aux1 in aux
			aux2 = aux1.to_s.split("\n")
			puts "-Titulo:"
			puts aux2[0]
			puts "-Entidades:"
			p aux1.entidades
			puts "---------"
		end
		puts ""
	end
	def agruparN(noticias)
		o = Operaciones.new
		aux = o.agruparNoticias(noticias)
		p aux
		numGrupos = 1
		numGruposTam1 = 0
		numGrupoEqFecha = 0
		numGrupoDisFecha = 0
		tamGrupo = []
		pClave=[]
		for aux1 in aux #Grupo noticias
			puts "\nGrupo #{numGrupos}\n"
			nNot = 0
			pClaveAux = []
			
			if o.fechasIguales(aux1)
				numGrupoEqFecha+= 1
			else
				numGrupoDisFecha+=1
			end
				
			if (aux1.length == 1)
				numGruposTam1 += 1
			end
			
			for aux2 in aux1 #Noticia
				nNot += 1.to_f
				aux3 = aux2.to_s.split("\n")
				pClaveAux.concat(aux2.palabrasClave) 
				puts aux3[0]
			end
			pClave << pClaveAux.uniq
			tamGrupo << nNot
			numGrupos += 1
		end
		puts ""
		puts "Numero de grupos: #{numGrupos}"
		media = 0
		for aux4 in tamGrupo
			media += aux4
		end
		media = media / numGrupos
		puts "Media noticias por grupo: #{media.round(3)}"
		puts "Numero de grupos con solo una noticia: #{numGruposTam1}"
		puts "Numero de grupos con fechas iguales #{numGrupoEqFecha} y con fechas distintas #{numGrupoDisFecha}"
		puts ""
		puts "¿Ver palabras Clave? si / no"
		inp = gets.chomp
		if (inp == "si")
			aux6 = 1
			for aux5 in pClave
				puts "Palabras Clave grupo #{aux6}:"
				p aux5
				puts "-----------------------"
				aux6 += 1
			end
		end
		puts ""
	end

	lf = LecturaFichero.new
	o = Operaciones.new
	mn = Main.new
	
	exit = 0
	while (exit == 0)
		listN = lf.noticias
		puts "# ---------------------------------------------------"
		puts "# Opcion:"
		puts "# \t1 : listar fuentes"
		puts "# \t2 : listar para cada fuente las noticias mostrando el titulo erroneo" 
		puts "# \t    y normalizado "
		puts "# \t3 : listar para una fuente los titulares de las noticias publicadas" 
		puts "# \t    por esa fuente"
		puts "# \t4 : listar para una fuente y fecha los titulares de las noticias" 
		puts "# \t    publicadas por esa fuente en esa fecha"
		puts "# \t5 : listar para una fuente los titulares de las noticias cortas que"
		puts "# \t    se  puedan ampliar"
		puts "# \t6 : listar para un número de párrafos los titulares de las noticias"
		puts "# \t    con mayor o igual numero"
		puts "# \t7 : listar para una cadena las noticas que contengan esa cadena en" 
		puts "# \t    el titulo"
		puts "# \t8 : listar todas las noticias ordenadas"
		puts "# \t9 : listar para una fuente las Entidades de cada noticia"
		puts "# \t10: agrupar noticias  con datos sobre ellos"
		puts "#......................................................................."
		puts "# \tescribir 'exit' para salir."
		
		opcion = gets.chomp
		
		case opcion
		when '1'
			puts "Fuentes:"
			puts o.listaFuentes(listN)
		when '2'
			puts "Titulos normalizados de cada fuente:"
			mn.titulosNormalizadosFuente(listN)
		when '3'
			puts "¿Que fuente?"
			inp = gets.chomp
			mn.titulosPorFuente(listN,inp)
		when '4'
			puts "¿Que fuente?"
			inp1 = gets.chomp
			puts "¿Que fecha? (formato dd/mm/aaaa)"
			inp2 = gets.chop
			puts "Titulos:"
			mn.titulosPorFuenteFecha(listN,inp1,inp2)
		when '5'
			puts "¿Que fuentes?"
			inp = gets.chomp
			puts "Titulos:"
			mn.titulosPorFuenteAmpliables(listN,inp)
		when '6'
			puts "¿Que numero de parrafos?"
			inp = gets.chomp
			puts "Titulos:"
			mn.noticiasPorParrafos(listN,inp)
		when '7'
			puts "¿Que cadena?"
			inp = gets.chomp
			puts "Titulos:"
			mn.noticiasPorCadena(listN,inp)
		when '8'
			puts "Noticias Ordenadas:"
			mn.noticiasOrdendas(listN)
		when '9'
			puts "¿Que fuentes?"
			inp = gets.chomp
			puts "Entidades por noticia"
			mn.entidadesPorNoticiaFuente(listN,inp)
		when '10'
			puts "Noticias agrupadas y datos:"
			mn.agruparN(listN)
		when 'exit'
			puts "Saliendo"
			exit = 1
		else 
			puts "Entrada erronea"
		end
	end #while
end