import 'dart:async';
import 'package:carup/home_page.dart';
import 'package:carup/userDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'Services/backendServices.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  bool _isLoading = false;
  bool _rememberCredentials = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  Future<void> _loadRememberedCredentials() async {
    final username = await storage.read(key: 'username');
    final password = await storage.read(key: 'password');

    if (username != null && password != null) {
      setState(() {
        _usernameController.text = username;
        _passwordController.text = password;
        _rememberCredentials = true;
      });
    }
  }

  Future<void> _login(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;


    if (_rememberCredentials) {
      await storage.write(key: 'username', value: username);
      await storage.write(key: 'password', value: password);
    } else {
      await storage.delete(key: 'username');
      await storage.delete(key: 'password');
    }

    final apiService = ApiServices();

    if(username != "" && password != ""){
      setState(() {
        _isLoading = true;
      });

      try {
        final user = await apiService.getLoginData(username, password).timeout(const Duration(seconds: 8));
        if (user != null) {
          if (user.statusCode == 200) {
            print("ENTRAMOS! Usuario autorizado!");
            final userProvider = Provider.of<userDataProvider>(context, listen: false);

            userProvider.data.nombre = user.nombre;
            userProvider.data.token = user.token;
            userProvider.data.idUsrMobile = user.idUsrMobile;

            if (!mounted) return;
            /*
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => home_page()),
            );*/
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => home_page(),
              ),
            );
          } else {
            print("Usuario y contraseña invalido");
            if (!mounted) return;
            _mostrarDialogo(context, "Usuario o Contraseña incorrectos...");
          }

          // Navegar a la siguiente pantalla o realizar acciones según la autenticación exitosa
        } else {
          if (!mounted) return;
          _mostrarDialogo(context, "Error de login");
        }
      } on TimeoutException {
        if (!mounted) return;
        _mostrarDialogo(context, "Error de TimeOut");

      }
      catch (error) {
        if (!mounted) return;
        _mostrarDialogo(context, "Hubo un error");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else{
      _mostrarDialogo(context, "Debe ingresar los datos");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _page()
    );
  }

  Widget _page() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/imgs/logoHeader.png', width: 300),
            Image.asset('assets/imgs/newTruck.png', width: 280),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: _inputField("Usuario",_usernameController,
                  hintText: "  Ingrese su usuario...",
                  iconPrefix: const Icon(Icons.person, color: Colors.black54)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: _inputField("Clave", _passwordController,
                  isPassword: true,
                  hintText: "  Ingrese la clave...",
                  iconPrefix: const Icon(Icons.lock, color: Colors.black54)),
            ),


            Row(
              children: [
                Checkbox(
                  value: _rememberCredentials,
                  onChanged: (value) {
                    setState(() {
                      _rememberCredentials = value!;
                    });
                  },
                ),
                const Text('Recordar mis credenciales?'),
              ],
            ),

            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator():
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(180, 30),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Entrar',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label,TextEditingController controller,
      {isPassword = false, Icon? iconPrefix, String? hintText}) {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      style: const TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          label: Text(label),
          prefixIcon: iconPrefix,
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor))),
      obscureText: isPassword,
    );
  }



}

// Función muestra Diálogo
void _mostrarDialogo(BuildContext context, textInformation) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text('Login'),
        content: Text(textInformation),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(_).pop(); // Cerrar el diálogo
            },
            child: const Text('Cerrar'),
          ),
        ],
      );
    },
  );
}

