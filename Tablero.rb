class Tablero
  attr_accessor :tablero, :jugador1, :jugador2, :turno
  
  def initialize(jugador1="Darth Vader", jugador2="Master Yoda")
    @tablero = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
    @jugador1 = jugador1
    @jugador2 = jugador2
    @turno = 1
  end
  
  #
  # LLENA EL TABLERO CON JUGADAS DE PRUEBA PARA CASOS ESPECIFICOS
  # 
  # una jugada sencilla que tiene algunas casillas llenas
  def jugada_de_prueba1
    self.tablero = [[1, 2, 0], [1, 2, 0], [2, 1, 1]]
    self.turno = 2
  end
  # jugador 1 gana en linea izquierda
  def jugada_de_prueba2
    self.tablero = [[1, 2, 0], [1, 2, 0], [1, 0, 0]]
	self.turno = 2  
  end
  # jugador 1 gana con diagoal
  def jugada_de_prueba3
  	self.tablero = [[1, 1, 2], [2, 1, 0], [0, 2, 1]]
  	self.turno = 2
  end
  # tablero lleno pero sin ganadores
  def jugada_de_prueba4
    self.tablero = [[1, 1, 2], [2, 2, 1], [1, 2, 2]]
    self.turno = 1
  end
  # Jugador 1 gana en la primera linea
  def jugada_de_prueba5
    self.tablero = [[1, 1, 1], [2, 2, 0], [0, 0, 0]]
    self.turno = 1
  end

  
  # Esta funcion dibuja un tablero en un front-end
  #
  def dibujar_tablero
    fil = 0
    self.tablero.each do |l|
      col = 0
      l.each do |c|        
        print " "
        case c
        when 1
          print "X"
        when 2 
          print "O"
        else
          print " "
        end
        print " "
        col += 1
        print "|" unless col == self.tablero[fil].length
      end
      fil += 1
      print "\n"
      print "-----------\n" unless fil == self.tablero.length
      if fil == self.tablero.length
        print "\n"
      end
    end
  end

  # Recorre el array mostrando sus valores y lo hace de la forma
  # mas eficiente en el back end
  #
  def back_end
    self.tablero.each do |l|
      print "["
      l.each do |c|
        print " #{c.to_s},"
      end
      print "]\n"
    end
  end

  # devuelve false si el juego puede seguir y true si ya no se puede seguir
  #
  def se_acabo?
  	if gano?(1)
  		return true
  	elsif gano?(2)
  		return true
  	elsif lleno?
 		return true
 	else
 		return false  			
  	end
  end

  # Comprueba si el jugador gano por filas, columnas o diagonal
  #
  def gano?(jugador)
  	if gano_en_filas?(jugador)
  		return true
  	elsif gano_en_columnas?(jugador)
  		return true
  	elsif gano_en_diagonales?(jugador)
  		return true
  	else
  		return false
  	end
  end

  # Comprueba si el jugador ha ganado en filas
  #
  def gano_en_filas?(jugador)
  	fila0 = false
  	fila1 = false
  	fila2 = false
  	if self.tablero[0] == [jugador, jugador, jugador]
  	  fila0 = true
  	end
  	if self.tablero[1] == [jugador, jugador, jugador]
  	  fila1 = true
  	end
  	if self.tablero[2] == [jugador, jugador, jugador]
  	  fila2 = true
  	end
   	return (fila0 or fila1 or fila2)
  end

  # Comprueba si el jugador ha ganado en columnas
  #
  def gano_en_columnas?(jugador)
  	col0 = false
  	col1 = false
  	col2 = false
  	if [ self.tablero[0][0], self.tablero[1][0], self.tablero[2][0] ] == [jugador, jugador, jugador]
  	  col0 = true
  	end
  	if [ self.tablero[0][1], self.tablero[1][1], self.tablero[2][1] ] == [jugador, jugador, jugador]
  	  col1 = true
  	end
  	if [ self.tablero[0][2], self.tablero[1][2], self.tablero[2][2] ] == [jugador, jugador, jugador]
  	  col2 = true
  	end
   	return (col0 or col1 or col2)
  end

  # Comrpueva si el jugador gano en diagonales
  #
  def gano_en_diagonales?(jugador)
  	diago0 = false
  	diago1 = false
  	diago2 = false
  	if [ self.tablero[0][0], self.tablero[1][1], self.tablero[2][2] ] == [jugador, jugador, jugador]
  	  diago0 = true
  	end
  	if [ self.tablero[0][2], self.tablero[1][1], self.tablero[2][0] ] == [jugador, jugador, jugador]
  	  diago1 = true
  	end
   	return (diago0 or diago1 or diago2)
  end
  
  # Comprueba si todas las casillas estan ocupadas pero sin ganador
  #
  def lleno?
  	!self.hay_espacio?
  end
  
  # Comprueba si hay alguna casilla libre
  #
  def hay_espacio?
  	hay_campo = false
  	self.tablero.each do |l|
      l.each do |c|
        if c == 0
        	hay_campo = true
  		end 	
      end
    end
    return hay_campo
  end


  # hace que un jugador marque una jugada en una fila y una columna
  #
  def marcar(jugador, fila, columna)
  	if self.jugada_valida?(fila,columna)
  		self.tablero[fila][columna]=jugador
  		return true
  	else
  		return false
  	end
  end

  # Solicita las pociones para marcar
  #
  def solicitar_marca
  	j = "self.jugador" + self.turno.to_s
	begin
	  	puts "Te toca jugardor #{eval j}"
	  	puts "En que fila"
	  	fila = gets.chomp
	  	fila = fila.to_i
	  	puts "En que columna"
	  	columna = gets.chomp
	    columna = columna.to_i
  	end while !self.marcar(self.turno, fila, columna)
  	self.turno = ((self.turno == 1) ? 2 : 1)
  end

  # esta funcion verifica si la casilla donde se desea marcar esta en blanco 
  # o dentro del tablero
  #
  def jugada_valida?(f,c)
  	valida=true
  	valida = ( valida and (c<3 and c>=0) )
  	valida = ( valida and (f<3 and f>=0) )
  	puts valida.to_s
  	if valida
  	  valida = ( valida and (self.tablero[f][c] == 0) )
  	end
  	return valida
  end

  # imprime la solicitud de nombre para el jugador 1 y almacena la variable
  #
  def solicitar_nombre_j1
  	puts "Cual es el nombre para el jugador"
  	self.jugador1 = gets.chomp
  	puts "bienvenido #{self.jugador1}"
  end

  # imprime la solicitud de nombre para el jugador 2 y almacena la variable
  #
  def solicitar_nombre_j2
  	puts "Cual es el nombre para el jugador 2"
  	self.jugador2 = gets.chomp
  	puts "bienvenido #{self.jugador2}"
  end

  # inicia un juego, hace un setting de los nombres de los jugadores
  #
  def asignar_nombres
  	self.solicitar_nombre_j1
  	self.solicitar_nombre_j2
  end

  # Anuncia el ganador o el empate y pregunta si quiere una revancha
  #
  def acabar_el_juego
  	ganador = 0
  	if self.gano?(1)
  		ganador = 1
  	elsif self.gano?(2)
  		ganador = 2
  	else 
  		ganador = 0
  	end
  	if ganador == 0
  		puts "Ha sido un empate"
  		self.de_nuevo?
  	else
  		puts "Ha ganado el jugador #{ganador}"
  		self.de_nuevo?
  	end

  end

  # Pregunta si se quiere empezar una nueva partida
  #
  def de_nuevo?
  	puts "Jugar de nuevo? (s/n)"
  		respuesta = gets.chomp
  			if respuesta == "s"
  				@tablero = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
  				if self.menu == "1"
  				self.jugar
  			 	elsif self.menu == "2"
  			 	self.modo
  			 	end	
  			else
  				@tablero = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
  				puts "Gracias por jugar"
  				self.menu
  			end
  	
  end

  # empieza un juego y luego marca las jugadas hasta que el juego acabe
  # es el encargado de controlar a quien le toca
  #
  def jugar
  	self.asignar_nombres
  	begin
  		self.dibujar_tablero
	  	self.solicitar_marca
	end  while !self.se_acabo?
	self.dibujar_tablero
	self.acabar_el_juego
  end

  # Menu del juego y seleccion de modo de juego
  #
  def menu
  	modo = 0
  	puts "Bienvenido al juego de 3 en Raya"
  	puts "Escoja su modo de juego"
  	puts "1) Contra IA"
	puts "2) Contra jugador"
	modo = gets.chomp
	if modo == "1"
		@tablero = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
		self.modo
	elsif modo == "2"
		@tablero = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
		self.jugar
	end								
  end
  # Jugador IA
  #
  def compu
  		begin
			numeroF = %w[ 0 1 2]
		  	num_aleatF = rand(numeroF.length)
		  	fila = numeroF[num_aleatF]
		  	fila = fila.to_i
		  	numeroC = %w[ 0 1 2]
		  	num_aleatC = rand(numeroC.length)
		  	columna = numeroC[num_aleatC]
		  	columna = columna.to_i
		end while !self.marcar(self.turno, fila, columna)
		self.marcar(self.turno, fila, columna)
  end
  # Jugadas en modo ia
  #
  def modo
  	self.turno = 1
	self.solicitar_nombre_j1
	begin
		if se_acabo? == false
		self.dibujar_tablero
	  	self.marca_modo
	  	end
	  	if se_acabo? == false
	  	self.dibujar_tablero
	  	self.compu
	  	end
	  	self.turno = ((self.turno == 1) ? 2 : 1)
	end while !se_acabo?
	self.dibujar_tablero
	self.acabar_el_juego
  end
  # Solista marca de jugador 1 en modo ia
  #
  def marca_modo
  	begin
	  	puts "Te toca jugardor #{self.jugador1}"
	  	puts "En que fila"
	  	fila = gets.chomp
	  	fila = fila.to_i
	  	puts "En que columna"
	  	columna = gets.chomp
	    columna = columna.to_i
  	end while !self.marcar(self.turno, fila, columna)
  	self.turno = ((self.turno == 1) ? 2 : 1)
  end

  # nada
  #
  def ahorro(dias=365)
  	centavos = 1
  	contador = 0
  	print centavos
	begin
		contador = contador + centavos
		centavos += 1
	end while centavos <= dias
    contador
  end	
end

t = Tablero.new
