import 'package:capturacognitivajaveriana/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Color(0xfffafafa),
            appBar: AppBar(
              title: Text("Captura cognitiva"),
              actions: [
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  controller.logout();
                },
              )
            ]),
            body: Container(
              color: Color(0xffFAFAFA),
              constraints: BoxConstraints.expand(),
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Material(
                    elevation: 2.0,
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text("Capturar imagen"),
                      onTap: controller.goToCapture,
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
