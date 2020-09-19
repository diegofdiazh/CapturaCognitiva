import 'package:capturacognitivajaveriana/app/data/services/auth_service.dart';
import 'package:capturacognitivajaveriana/app/modules/reset_password/reset_controller.dart';
import 'package:get/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ResetPage extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final ThemeData theme = Theme.of(context);

    return GetBuilder<ResetController>(
      init: ResetController(authService: authService),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: theme.primaryColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
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
                        "Reset password",
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
                                "CAMBIAR CONTRASEÑA",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  controller.reset(_emailController.text);
                                }
                              },
                            )),
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
