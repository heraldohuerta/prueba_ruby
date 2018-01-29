###############################
######### READ FILE#############

def read_alum(file_name)
  file = File.open(file_name, 'r')
  alum = file.readlines.map(&:chomp).map { |lines| lines.split(', ') }
  file.close
  alum
end
file_alumnos = read_alum("./alumnos.txt")


#########################################
# CONVIERTE EL ARREGLO EN HASH
#########################################
alumnos = {}
inasistencias = {}
inasistencia = 0
file_alumnos.each do |valor|
  alumnos[valor[0].to_sym] = valor[1..-1].map{|v| v == 'A' ? 0 : v.to_i }
  inasistencia = 0
  valor[1..-1].each{|v| inasistencia+=1 if v == 'A'}
  inasistencias[valor[0].to_sym] = inasistencia
end


def primedio(alumnos)
####sacar promedios
puts "****************************************************************************************"
puts "****************PROMEDIO ALUMNOS********************************************************"
puts "****************************************************************************************"
alumnos.each {|key,notas| puts "El promedio de notas de #{key} #{notas} es:#{notas.sum / notas.count }"}
end

def inasistencia(alumnos)
  puts "****************************************************************************************"
  puts "****************INASISTENCIA ALUMNOS****************************************************"
  puts "****************************************************************************************"
  alumnos.each {|key,inas| puts "Las inasistencias del alumno #{key} son:#{inas}"}
end


def aprobados(alumnos,nota)
  puts "La nota de aprobación es: #{nota}"
  puts "Alumnos aprobados son:"
  alumnos.each do |key,notas|
    promedios = notas.sum / notas.count
    if (promedios >= nota)
      puts "Alumno   #{key}, con notas  #{notas} aprobo con promedio: #{notas.sum / notas.count  }"
    end
  end
end

###############################
#########MENU##################

seleccion = 1
while (seleccion !=4)

  puts "****************************************************************************************"
  puts "****************SISTEMA DE NOTAS RUBY***************************************************"
  puts "****************************************************************************************"
  puts "1, Ver promedio de alumnos"
  puts "2, Revisar Inasistencias"
  puts "3, Ver Alumnos aprobados"
  puts "4, <<Salir>>"
  print "Seleccione la opcion a ejecutar (4 = salir):"
  seleccion =   gets.chomp.to_i
  puts ""
  case seleccion
      when 1
         primedio(alumnos)
      when 2
        inasistencia(inasistencias)
      when 3
        puts "****************************************************************************************"
        puts "****************APROBADOS ALUMNOS*******************************************************"
        puts "****************************************************************************************"
        puts "\n\n"
        puts "Ingrese nota de aprobacion:"
        nota = gets.chomp.to_i

        nota = 5 if nota == 0

        aprobados(alumnos,nota)
      when 4
        puts ">>>>>A selccionado Salir<<<"
     else
       puts "Opcion No valida"
       gets.chomp.to_i
  end
end
