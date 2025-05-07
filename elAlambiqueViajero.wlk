object luke {
  var cantidadViajes = 0
  var recuerdo = null
  var vehiculo = alambiqueVeloz
  
  method cantidadViajes() = cantidadViajes
  
  method viajar(lugar) {
    if (lugar.puedeLlegar(vehiculo)) {
      cantidadViajes += 1
      recuerdo = lugar.recuerdoTipico()
      vehiculo.desgaste()
    }
  }
  
  method recuerdo() = recuerdo
  
  method vehiculo(nuevo) {
    vehiculo = nuevo
  }
}

object alambiqueVeloz {
  var rapido = true
  var combustible = 20
  const consumoPorViaje = 10
  var patente = "AB123JK"
  
  method puedeFuncionar() = combustible >= consumoPorViaje
  
  method desgaste() {
    combustible -= consumoPorViaje
  }
  
  method rapido() = rapido
  
  method patenteValida() = patente.head() == "A"
  
  method velocidad() = 100
}

object paris {
  method recuerdoTipico() = "Llavero Torre Eiffel"
  
  method puedeLlegar(movil) = movil.puedeFuncionar()
}

object buenosAires {
  method recuerdoTipico() = "Mate"
  
  method puedeLlegar(auto) = auto.rapido()
}

object bagdad {
  var recuerdo = "bidon de petroleo"
  
  method recuerdoTipico() = recuerdo
  
  method recuerdo(nuevo) {
    recuerdo = nuevo
  }
  
  method puedeLlegar(cualquierCosa) = true
}

object lasVegas {
  var homenaje = paris
  
  method homenaje(lugar) {
    homenaje = lugar
  }
  
  method recuerdoTipico() = homenaje.recuerdoTipico()
  
  method puedeLlegar(vehiculo) = homenaje.puedeLlegar(vehiculo)
}

object antigualla {
  const gangsters = ["hola", "como", "te", "va", "a", "vos", "!!"]
  
  method puedeFuncionar() = gangsters.even()
  
  method rapido() = gangsters.size() > 6
  
  method desgaste() = gangsters.size()
  
  method patenteValida() = chatarra.rapido()
  
  method velocidad() = gangsters.sum({ x => x.length() })
  
  method bajarGangsters(gangster) = gangsters.remove(gangster)
  
  method subirGangsters(gangster) = gangsters.add(gangster)
  
  method gangsters() = gangsters
  
  method cantidadGangsters() = gangsters.size()
}

object chatarra {
  var cañones = 10
  var municiones = "ACME"
  
  method puedeFuncionar() = (municiones == "ACME") and cañones.between(6, 12)
  
  method rapido() = municiones.size() < cañones
  
  method desgaste() {
    cañones = (cañones / 2).roundUp(0)
    if (cañones < 5) {
      municiones += " Obsoleto"
    }
  }
  
  method patenteValida() = municiones.take(4) == "ACME"
  
  method cañones() = cañones
  
  method velocidad() = 50
}

object convertible {
  var convertido = antigualla
  
  method puedeFuncionar() = convertido.puedeFuncionar()
  
  method rapido() = convertido.rapido()
  
  method desgaste() {
    convertido.desgaste()
  }
  
  method convertir(vehiculo) {
    convertido = vehiculo
  }
  
  method patenteValida() = convertido.patenteValida()
  
  method velocidad() = convertido.velocidad()
}

object maquinaMalevola {
  var velocidad = 200
  
  method puedeFuncionar() = true
  
  method rapido() = true
  
  method desgaste() { velocidad = velocidad - 10}
  
  method patenteValida() = 0
  
  method hacerTrampa() { velocidad = velocidad - 50 }
  
  method velocidad() = velocidad
}

object hurlingham {
  method puedeLlegar(
    vehiculo
  ) = (vehiculo.puedeFuncionar() and vehiculo.rapido()) and vehiculo.patenteValida()
  
  method recuerdoTipico() = "sticker de la Unahur"
}

object moto {
  method rapido() = true
  
  method puedeFuncionar() = not moto.rapido()
  
  method desgaste() {
    
  }
  
  method patenteValida() = false
}

object carrera {
  const inscriptos = []
  const rechazados = []
  var ciudad = paris
  
  method inscribirORechazar(vehiculo) {
    if (ciudad.puedeLlegar(vehiculo))
       inscriptos.add(vehiculo)
    else 
       rechazados.add(vehiculo)
  }
  method replanificacion(nuevaCiudad) {
    ciudad = nuevaCiudad
    inscriptos.filter{a=>not ciudad.puedeLlegar(a)}.forEach({a=>
      rechazados.add(a)
      inscriptos.remove(a)
    })
    rechazados.filter{a=>ciudad.puedeLlegar(a)}.forEach({a=>
      rechazados.remove(a)
      inscriptos.add(a)
    }) 
  }

  method replanificacion2(nuevaCiudad) {
    ciudad = nuevaCiudad
    rechazados.addAll(inscriptos)
    inscriptos.clear()
    inscriptos.addAll(rechazados.filter{a=>ciudad.puedeLlegar(a)})
    rechazados.removeAll(inscriptos)
  }
  method replanificacion3(nuevaCiudad) {
    ciudad = nuevaCiudad
    const nueva = rechazados + inscriptos
    inscriptos.clear()
    rechazados.clear()
    nueva.forEach{a=>self.inscribirORechazar(a)}
  }

  method avisarALosVehiculos() {
    inscriptos.forEach({ i => i.desgaste() })
  }
  
  method ganador() = inscriptos.max({ i => i.velocidad() })
  
  method ciudad() = ciudad
}

