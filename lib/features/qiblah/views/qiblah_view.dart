import 'package:depiproject/features/qiblah/views/widgets/compass_contraller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class QiblahView extends StatelessWidget {
  const QiblahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qiblah View'),
      ),
      body: GetBuilder<CompassContraller>(
        init: CompassContraller(),
        builder: (controller) {
          return controller.hasPermissions
              ? StreamBuilder(
                  stream: FlutterCompass.events,
                  builder: (context, AsyncSnapshot<CompassEvent> snapshot) {
                    if (snapshot.hasError ||
                        snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.data == ConnectionState.none) {
                      return Text('wait');
                    } else {
                      if (snapshot.data!.heading == null) {
                        return const Center(
                          child: Text("Device does not have sensors !"),
                        );
                      } else {
                        return Column(
                          children: [
                            Text("${snapshot.data!.heading}°"),
                            Material(
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              elevation: 4,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Transform.rotate(
                                  angle: ((snapshot.data!.heading ?? 0) *
                                      (3.14159265359 / 180) *
                                      -1),
                                  child: Image.asset(
                                    'assets/images/image.png',
                                    color: Colors.red,
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }
                  },
                )
              : Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.requestPermission();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'طلب صلاحية الموقع',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
