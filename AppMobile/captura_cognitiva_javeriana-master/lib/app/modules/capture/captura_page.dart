import 'package:capturacognitivajaveriana/app/data/services/captura_service.dart';
import 'package:capturacognitivajaveriana/app/modules/capture/captura_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class CapturaPage extends StatelessWidget {
  final CapturaService capturaService = CapturaService();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CapturaController>(
        init: CapturaController(capturaService: capturaService),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(title: Text("Capturar imagen")),
            body: Container(
              constraints: BoxConstraints.expand(),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2.0, color: Colors.blueGrey[200]),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Obx(
                        () => AspectRatio(
                          aspectRatio: 1,
                          child: controller.foto != null
                              ? controller.mostrarFoto()
                              : Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Colors.blueGrey[200],
                                ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                          color: Colors.blueAccent,
                          child: Text(
                            "TOMAR FOTO",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: controller.tomarFoto),
                    ),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                          color: Colors.blueAccent,
                          child: Text(
                            "SELECCIONAR DE LA GALERÍA",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: controller.seleccionarFoto),
                    ),
                    Text("Resultado"),
                    Obx(() => controller.loading
                        ? CircularProgressIndicator()
                        : SizedBox.shrink()),
                    Obx(
                      () => Text(controller.result.toString()),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
