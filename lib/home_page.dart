
import 'package:carup/userDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class home_page extends StatelessWidget {
  const home_page({super.key});

  @override
  Widget build(BuildContext context) {
   var user = Provider.of<userDataProvider>(context, listen: false);


    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/imgs/auxilioCapot.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white30,
        appBar: AppBar(
            title: const Text('Bienvenid@s!'),
            iconTheme: IconThemeData(color: Colors.white)
            //backgroundColor: Theme.of(context).primaryColor
            ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/imgs/color_logo_alpha.png'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "@${user.data.nombre}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                title: Text('Mis servicios'),
                onTap: () {
                  /*
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MisServicios(),
                    ),
                  );*/
                  Navigator.popAndPushNamed(context, 'MisServicios');
                },
              ),
              Divider(),
              ListTile(
                title: Text('Todos los servicios'),
                onTap: () {
                  Navigator.popAndPushNamed(context, 'TodosServicios');
                },
              ),
              Divider(),
              ListTile(
                title: Text('Cerrar Sesión'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                  );
                },
              ),
              Divider(),
            ],
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
              SizedBox(
              height:40),
                SizedBox(
                  height: 210,
                  child: Card(
                    color: Colors.white60,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text("MISIÓN", style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('''
Somos un equipo comprometido y eficaz que buscamos la satisfacción del cliente brindando servicios de auxilio las 24 hs. del día con rentabilidad, calidad, seguridad y cuidado ambiental.
                          ''',style: TextStyle(fontSize: 16),),
                          ],
                        ),
                      ),
                      //Text
                    ), //Center
                  ),
                ),
                SizedBox(
                  height: 320,
                  child: Card(
                    color: Colors.white60,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text("VISIÓN", style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('''
CAR.UP crece día a día renovando y ampliando los servicios a sus clientes, apostando a su fidelización como líder en el mercado.

Con el compromiso de brindar soluciones rápidas y efectivas cuidando el medio ambiente, con personal competente y vocación de servicio.
                          ''',style: TextStyle(fontSize: 16),),
                          ],
                        ),
                      ),
                      //Text
                    ), //Center
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
