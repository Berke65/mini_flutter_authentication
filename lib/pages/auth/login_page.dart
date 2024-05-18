import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/pages/auth/home_page.dart';
import 'package:untitled2/services/auth_services.dart';
import 'package:untitled2/widgets/custom_text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, passwd;
  final formKey = GlobalKey<FormState>(); // hepsini form widgetinin icine aldıgımız formu dısarıdan kontrol etmek icin kullanılır
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff21254a),
      //textDirection: TextDirection.ltr,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TopImage(height),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      titleText(),
                      customSizedBox(),
                      EmailTextField(),
                      customSizedBox(),
                      passwdTextField(),
                      customSizedBox(),
                      forgotPasswdButton(),
                      SignInButton(),
                      CustomTextButton(
                          onPressed: () => Navigator.pushNamed(context, '/signUp'),
                          buttonText: 'Hesap Oluştur'),
                      CustomTextButton(
                          onPressed: () async {
                        final result = await authService.signInAnonymous();
                        if(result != null)
                          {
                            Navigator.pushReplacementNamed(context, '/homePage');
                          }
                        else {
                          print('hata var dayı');
                        }
                      },
                          buttonText: 'Misafir Girişi')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Center SignInButton() {
    return Center(
      child: TextButton(
        onPressed: signIn,
        child: Container(
          height: 50,
          width: 150,
          margin: EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xff312274F),
          ),
          child: Center(
            child: Text(
              'Giriş Yap',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final result = await authService.signIn(email, passwd);
      if (result == "success") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Hata'),
                content: Text(result!),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Geri Don'))
                ],
              );
            });
      }
    }
  }

  Center forgotPasswdButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Şifremi Unuttum',
          style: TextStyle(color: Colors.pink[200]),
        ),
      ),
    );
  }

  TextFormField passwdTextField() {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Lütfen Bilgileri Eksiksiz Giriniz';
          } else {}
        },
        onSaved: (value) {
          passwd = (value)!;
        },
        obscureText: true,
        decoration: textfielddec('Sifre'),
        style: TextStyle(color: Colors.white));
  }

  TextFormField EmailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Lütfen Bilgileri Eksiksiz Doldurunuz';
        } else {}
      },
      onSaved: (value) {
        email = (value)!; // ünlemin anlamı value bos olmamalı demek oluyor
      },
      decoration: textfielddec('Email'),
      style: TextStyle(color: Colors.white),
    );
  }

  Text titleText() {
    return Text(
      'Merhaba,\nHoşgeldiniz!',
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container TopImage(double height) {
    return Container(
      height: height * 0.20,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/a.png"),
        ),
      ),
    );
  }

  Widget customSizedBox() => SizedBox(
        height: 20,
      );

  InputDecoration textfielddec(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }
}
