import 'dart:ui';

import 'package:capturacognitivajaveriana/app/routes/app_pages.dart';
import "package:get/get.dart";
import 'package:flutter/material.dart';
import 'package:capturacognitivajaveriana/app/data/services/auth_service.dart';
import 'package:capturacognitivajaveriana/app/modules/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final ThemeData theme = Theme.of(context);

    return GetBuilder<LoginController>(
      init: LoginController(authService: authService),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: theme.primaryColor,
            appBar: AppBar(
              elevation: 0.0,
            ),
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Inicia sesión",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .apply(fontWeightDelta: 900),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              isDense: true, labelText: "Correo"),
                          validator: (value) {
                            if (GetUtils.isEmail(value)) {
                              return null;
                            }
                            return "Ingrese un correo válido";
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.lock_outline),
                        title: TextFormField(
                          obscureText: true,
                          controller: _passController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              isDense: true, labelText: "Contraseña"),
                          validator: (value) {
                            if (GetUtils.isLengthGreaterThan(value, 4)) {
                              return null;
                            }
                            return "Contraseña muy corta";
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Obx(() => FlatButton.icon(
                              icon: controller.loading
                                  ? SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                        strokeWidth: 3.0,
                                      ))
                                  : SizedBox.shrink(),
                              color: theme.accentColor,
                              label: Text(
                                "INGRESAR",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  controller.login(_emailController.text,
                                      _passController.text);
                                }
                              },
                            )),
                      ),
                      Container(
                        width: double.infinity,
                        child: FlatButton(
                          color: Colors.blueGrey[200],
                          child: Text(
                            "CAMBIAR CONTRASEÑA",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.RESET);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
