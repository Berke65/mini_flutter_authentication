import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email, passwd;
  final formKey = GlobalKey<
      FormState>(); // hepsini form widgetinin icine aldıgımız formu dısarıdan kontrol etmek icin kullanılır
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff21254a),
      //textDirection: TextDirection.ltr,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TopImage(height),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey, // formu kontrol etmek icin olusturdugumuz
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText(),
                      customSizedBox(),
                      EmailTextField(),
                      customSizedBox(),
                      passwdTextField(),
                      customSizedBox(),
                      SignUpButton(),
                      customSizedBox(),
                      backToLoginPageButton()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center SignUpButton() {
    return Center(
      child: TextButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            try {
              var userResult =
                  await firebaseAuth.createUserWithEmailAndPassword(
                      email: email, password: passwd);
              formKey.currentState!.reset();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Hesap Oluşturuldu , Giriş Yapmak İçin Yönlendiriliyorsunuz'),
                ),
              );
              Navigator.pushReplacementNamed(context, '/loginPage');
              // ünlemlerinin az önce acıkladıgım ünlemle hepsinin kullanılma amacları aynı
            } catch (e) {
              print(e.toString());
            }
          } else {}
        },
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
              'Hesap Oluştur',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Center backToLoginPageButton() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, '/loginPage'),
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
              'Giris Sayfasına Dön',
              style: TextStyle(color: Colors.white),
            ),
          ),
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
