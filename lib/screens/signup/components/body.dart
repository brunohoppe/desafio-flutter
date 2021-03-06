import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/authentication_service.dart';
import '../../../components/input_field.dart';
import '../../signin/signin_screen.dart';

Future<String> get _localPath async {
  // final directory = await getApplicationDocumentsDirectory();

  // return directory.path;
}

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
  // final picker = ImagePicker();
  void showPassword() {
    setState(() {
      showingPassword = !showingPassword;
    });
  }

  Future<void> getImage() async {
    // final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //   } else {
    //     print('No image selected.');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: size.height * 0.3),
          Text(
            'Sign Up',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          SizedBox(height: size.height * 0.05),
          GestureDetector(
            onTap: getImage,
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.add_a_photo),
            ),
          ),
          SizedBox(height: size.height * 0.05),
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
            hintText: 'Password',
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
              child: Text('Sign Up'),
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
                      'Login',
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
