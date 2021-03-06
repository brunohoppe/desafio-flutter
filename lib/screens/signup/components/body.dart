import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../auth/authentication_service.dart';
import '../../../components/input_field.dart';
import '../../signin/signin_screen.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool showingPassword = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File _image;
  final picker = ImagePicker();
  void showPassword() {
    setState(() {
      showingPassword = !showingPassword;
    });
  }

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Nenhuma imagem selecionada');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.3),
          Text(
            'Cadastre-se',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          SizedBox(height: size.height * 0.05),
          Center(
            child: GestureDetector(
              // TODO: Save user selfie in database
              onTap: getImage,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: _image == null
                    ? Icon(Icons.add_a_photo)
                    : ClipRRect(
                        child: Image.file(
                          _image,
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
          // TODO Confirm password field
          InputField(
            controller: emailController,
            prefixIcon: Icon(Icons.person),
            hintText: 'E-mail',
            onChanged: (value) {},
          ),
          InputField(
            controller: passwordController,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: showingPassword
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
              onPressed: showPassword,
            ),
            hintText: 'Senha',
            obscureText: !showingPassword,
            onChanged: (value) {},
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
              },
              child: Text('Salvar'),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Já possui uma conta? ',
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SigninScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Entrar!',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
