import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  AppBar _buildAppBar() {
    return AppBar();
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 0.0, bottom: 30.0),
          child: const Text(
            "Login .",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 0.0, bottom: 30.0),
          child: const Text(
            "Sign in with Email",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 16.0,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLoginBtn() {
    return GestureDetector(
        child: Container(
          width: 295.0,
          height: 44.0,
          margin: const EdgeInsets.only(top: 60.0, bottom: 30.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Sign in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          controller.handleLogin();
        });
  }

  Widget _buildEmailInput() {
    return Container(
        width: 295.0,
        height: 44.0,
        margin: const EdgeInsets.only(bottom: 20.0, top: 0.0),
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            hintText: "Enter your username",
            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 14.0,
          ),
          onChanged: (value) {
            controller.state.email.value = value;
          },
          maxLines: 1,
          autocorrect: false,
          obscureText: false,
        ));
  }

  Widget _buildPasswordInput() {
    return Container(
        width: 295.0,
        height: 44.0,
        margin: const EdgeInsets.only(bottom: 20.0, top: 0.0),
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: TextField(
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: "Enter your password",
            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 14.0,
          ),
          onChanged: (value) {
            controller.state.password.value = value;
          },
          maxLines: 1,
          autocorrect: false,
          obscureText: false,
        ));
  }

  Widget _buildSchoolIdInput() {
    return Container(
        width: 295.0,
        height: 44.0,
        margin: const EdgeInsets.only(bottom: 20.0, top: 0.0),
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: TextField(
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: "Enter your school id",
            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 14.0,
          ),
          onChanged: (value) {
            controller.state.schoolId.value = value;
          },
          maxLines: 1,
          autocorrect: false,
          obscureText: false,
        ));
  }

  Widget _forgotPassword() {
    return SizedBox(
      width: 260.0,
      height: 44.0,
      child: GestureDetector(
          child: const Text(
            "Forgot password?",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.underline,
              decorationColor: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 12.0,
            ),
          ),
          onTap: () {
            // Get.toNamed(AppRoutes.Forgot);
          }),
    );
  }

  Widget _bottomRegister() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Don't have an account?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 12.0,
          ),
        ),
        GestureDetector(
            child: const Text(
              "Register here",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
                fontSize: 12.0,
              ),
            ),
            onTap: () {
              // Get.toNamed(AppRoutes.Register);
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 15.0,
          ),
          sliver: SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 0.0, top: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLogo(),
                  _buildEmailInput(),
                  _buildPasswordInput(),
                  _buildSchoolIdInput(),
                  _forgotPassword(),
                  _buildLoginBtn(),
                  _bottomRegister()
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
