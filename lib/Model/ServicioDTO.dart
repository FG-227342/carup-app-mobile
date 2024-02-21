class ServicioDTO {
  int? idSrv;
  int? idTarea;
  String? fecha;
  String? hora;
  String? paisOrigen;
  String? ciudadOrigen;
  String? locOrigen;
  String? matricula;
  String? marca;
  String? modelo;
  String? color;
  String? calleOrigen;
  String? numPuertaOrigen;
  String? esquinaOrigen;
  String? falla;
  String? estado;
  String? horaAsignado;

  ServicioDTO(
      {this.idSrv,
        this.idTarea,
        this.fecha,
        this.hora,
        this.paisOrigen,
        this.ciudadOrigen,
        this.locOrigen,
        this.matricula,
        this.marca,
        this.modelo,
        this.color,
        this.calleOrigen,
        this.numPuertaOrigen,
        this.esquinaOrigen,
        this.falla,
        this.estado,
        this.horaAsignado
      });

  ServicioDTO.fromJson(Map<String, dynamic> json) {
    idSrv = json['idSrv'];
    idTarea = json['idTarea'];
    fecha = json['fecha'];
    hora = json['hora'];
    paisOrigen = json['paisOrigen'];
    ciudadOrigen = json['ciudadOrigen'];
    locOrigen = json['locOrigen'];
    matricula = json['matricula'];
    marca = json['marca'];
    modelo = json['modelo'];
    color = json['color'];
    calleOrigen = json['calleOrigen'];
    numPuertaOrigen = json['numPuertaOrigen'];
    esquinaOrigen = json['esquinaOrigen'];
    falla = json['falla'];
    estado = json['estado'];
    horaAsignado = json['horaAsignado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idSrv'] = this.idSrv;
    data['idTarea'] = this.idTarea;
    data['fecha'] = this.fecha;
    data['hora'] = this.hora;
    data['paisOrigen'] = this.paisOrigen;
    data['ciudadOrigen'] = this.ciudadOrigen;
    data['locOrigen'] = this.locOrigen;
    data['matricula'] = this.matricula;
    data['marca'] = this.marca;
    data['modelo'] = this.modelo;
    data['color'] = this.color;
    data['calleOrigen'] = this.calleOrigen;
    data['numPuertaOrigen'] = this.numPuertaOrigen;
    data['esquinaOrigen'] = this.esquinaOrigen;
    data['falla'] = this.falla;
    data['estado'] = this.estado;
    data['horaAsignado'] = this.horaAsignado;
    return data;
  }
}
