/*class Servicio{
  int id = 0;
  String calle = "";
  String matricula = "";
  String vehiculo ="";
  String? foto;
  String? estado;
  String? latOrigen;
  String? longOrigen;

  Servicio(this.id, this.calle, this.matricula, this.vehiculo, [this.foto, this.estado, this.latOrigen, this.longOrigen]);

  static Servicio fromJson(json) => Servicio(json['idSrv'],json['calleOrigen'],json['matricula']!= null ? json['matricula']:"",json['vehiculo'] != null ? json['vehiculo']:"");
}*/
/*
class Servicio {
  int? idSrv;
  int? idTarea;
  String? fecha;
  String? hora;
  int? idUsuario;
  int? paisOrigen;
  int? ciudadOrigen;
  int? locOrigen;
  int? zona;
  int? clienteId;
  int? idVehiculo;
  int? idMovil;
  int? idPrestador;
  String? latitud;
  String? longitud;
  String? calleOrigen;
  String? numPuertaOrigen;
  String? esquinaOrigen;
  int? idFalla;
  String? calleDestino;
  int? ciudadDestino;
  int? locDestino;
  String? observaciones;
  String? estado;
  int? llegadaLugar;

  Servicio(
      {this.idSrv,
        this.idTarea,
        this.fecha,
        this.hora,
        this.idUsuario,
        this.paisOrigen,
        this.ciudadOrigen,
        this.locOrigen,
        this.zona,
        this.clienteId,
        this.idVehiculo,
        this.idMovil,
        this.idPrestador,
        this.latitud,
        this.longitud,
        this.calleOrigen,
        this.numPuertaOrigen,
        this.esquinaOrigen,
        this.idFalla,
        this.calleDestino,
        this.ciudadDestino,
        this.locDestino,
        this.observaciones,
        this.estado,
        this.llegadaLugar});

  Servicio.fromJson(Map<String, dynamic> json) {
    idSrv = json['idSrv'];
    idTarea = json['idTarea'];
    fecha = json['fecha'];
    hora = json['hora'];
    idUsuario = json['idUsuario'];
    paisOrigen = json['paisOrigen'];
    ciudadOrigen = json['ciudadOrigen'];
    locOrigen = json['locOrigen'];
    zona = json['zona'];
    clienteId = json['clienteId'];
    idVehiculo = json['idVehiculo'];
    idMovil = json['idMovil'];
    idPrestador = json['idPrestador'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    calleOrigen = json['calleOrigen'];
    numPuertaOrigen = json['numPuertaOrigen'];
    esquinaOrigen = json['esquinaOrigen'];
    idFalla = json['idFalla'];
    calleDestino = json['calleDestino'];
    ciudadDestino = json['ciudadDestino'];
    locDestino = json['locDestino'];
    observaciones = json['observaciones'];
    estado = json['estado'];
    llegadaLugar = json['llegadaLugar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idSrv'] = this.idSrv;
    data['idTarea'] = this.idTarea;
    data['fecha'] = this.fecha;
    data['hora'] = this.hora;
    data['idUsuario'] = this.idUsuario;
    data['paisOrigen'] = this.paisOrigen;
    data['ciudadOrigen'] = this.ciudadOrigen;
    data['locOrigen'] = this.locOrigen;
    data['zona'] = this.zona;
    data['clienteId'] = this.clienteId;
    data['idVehiculo'] = this.idVehiculo;
    data['idMovil'] = this.idMovil;
    data['idPrestador'] = this.idPrestador;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['calleOrigen'] = this.calleOrigen;
    data['numPuertaOrigen'] = this.numPuertaOrigen;
    data['esquinaOrigen'] = this.esquinaOrigen;
    data['idFalla'] = this.idFalla;
    data['calleDestino'] = this.calleDestino;
    data['ciudadDestino'] = this.ciudadDestino;
    data['locDestino'] = this.locDestino;
    data['observaciones'] = this.observaciones;
    data['estado'] = this.estado;
    data['llegadaLugar'] = this.llegadaLugar;
    return data;
  }
}*/
class Servicio {
  int? idSrv;
  int? idTarea;
  String? fecha;
  String? hora;
  String? usuario;
  String? paisOrigen;
  String? ciudadOrigen;
  String? locOrigen;
  String? zona;
  String? nombreCliente;
  int? idVehiculo;
  String? matricula;
  String? marca;
  String? modelo;
  String? color;
  int? idMovil;
  int? idPrestador;
  String? latitud;
  String? longitud;
  String? calleOrigen;
  String? numPuertaOrigen;
  String? esquinaOrigen;
  String? falla;
  String? calleDestino;
  String? ciudadDestino;
  String? locDestino;
  String? observaciones;
  String? estado;
  int? llegadaLugar;

  Servicio(
      {this.idSrv,
        this.idTarea,
        this.fecha,
        this.hora,
        this.usuario,
        this.paisOrigen,
        this.ciudadOrigen,
        this.locOrigen,
        this.zona,
        this.nombreCliente,
        this.idVehiculo,
        this.matricula,
        this.marca,
        this.modelo,
        this.color,
        this.idMovil,
        this.idPrestador,
        this.latitud,
        this.longitud,
        this.calleOrigen,
        this.numPuertaOrigen,
        this.esquinaOrigen,
        this.falla,
        this.calleDestino,
        this.ciudadDestino,
        this.locDestino,
        this.observaciones,
        this.estado,
        this.llegadaLugar});

  Servicio.fromJson(Map<String, dynamic> json) {
    idSrv = json['idSrv'];
    idTarea = json['idTarea'];
    fecha = json['fecha'];
    hora = json['hora'];
    usuario = json['usuario'];
    paisOrigen = json['paisOrigen'];
    ciudadOrigen = json['ciudadOrigen'];
    locOrigen = json['locOrigen'];
    zona = json['zona'];
    nombreCliente = json['nombreCliente'];
    idVehiculo = json['idVehiculo'];
    matricula = json['matricula'];
    marca = json['marca'];
    modelo = json['modelo'];
    color = json['color'];
    idMovil = json['idMovil'];
    idPrestador = json['idPrestador'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    calleOrigen = json['calleOrigen'];
    numPuertaOrigen = json['numPuertaOrigen'];
    esquinaOrigen = json['esquinaOrigen'];
    falla = json['falla'];
    calleDestino = json['calleDestino'];
    ciudadDestino = json['ciudadDestino'];
    locDestino = json['locDestino'];
    observaciones = json['observaciones'];
    estado = json['estado'];
    llegadaLugar = json['llegadaLugar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idSrv'] = this.idSrv;
    data['idTarea'] = this.idTarea;
    data['fecha'] = this.fecha;
    data['hora'] = this.hora;
    data['usuario'] = this.usuario;
    data['paisOrigen'] = this.paisOrigen;
    data['ciudadOrigen'] = this.ciudadOrigen;
    data['locOrigen'] = this.locOrigen;
    data['zona'] = this.zona;
    data['nombreCliente'] = this.nombreCliente;
    data['idVehiculo'] = this.idVehiculo;
    data['matricula'] = this.matricula;
    data['marca'] = this.marca;
    data['modelo'] = this.modelo;
    data['color'] = this.color;
    data['idMovil'] = this.idMovil;
    data['idPrestador'] = this.idPrestador;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['calleOrigen'] = this.calleOrigen;
    data['numPuertaOrigen'] = this.numPuertaOrigen;
    data['esquinaOrigen'] = this.esquinaOrigen;
    data['falla'] = this.falla;
    data['calleDestino'] = this.calleDestino;
    data['ciudadDestino'] = this.ciudadDestino;
    data['locDestino'] = this.locDestino;
    data['observaciones'] = this.observaciones;
    data['estado'] = this.estado;
    data['llegadaLugar'] = this.llegadaLugar;
    return data;
  }

  @override
  String toString() {
    return 'Servicio{idSrv: $idSrv, idTarea: $idTarea, fecha: $fecha, hora: $hora, usuario: $usuario, paisOrigen: $paisOrigen, ciudadOrigen: $ciudadOrigen, locOrigen: $locOrigen, zona: $zona, nombreCliente: $nombreCliente, idVehiculo: $idVehiculo, matricula: $matricula, marca: $marca, modelo: $modelo, color: $color, idMovil: $idMovil, idPrestador: $idPrestador, latitud: $latitud, longitud: $longitud, calleOrigen: $calleOrigen, numPuertaOrigen: $numPuertaOrigen, esquinaOrigen: $esquinaOrigen, falla: $falla, calleDestino: $calleDestino, ciudadDestino: $ciudadDestino, locDestino: $locDestino, observaciones: $observaciones, estado: $estado, llegadaLugar: $llegadaLugar}';
  }
}
