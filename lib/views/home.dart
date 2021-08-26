import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:person_picker_v2/components/all_classes_component.dart';
import 'package:person_picker_v2/components/class_component.dart';
import 'package:person_picker_v2/components/styleized_button.dart';
import 'package:person_picker_v2/constants/logger.dart';
import 'package:person_picker_v2/controllers/app_controller.dart';
import 'package:person_picker_v2/controllers/class_controller.dart';
import 'package:person_picker_v2/controllers/participant_controller.dart';
import 'package:person_picker_v2/controllers/user_controller.dart';
import 'package:person_picker_v2/models/class.dart';
import 'package:person_picker_v2/models/participant.dart';
import 'package:person_picker_v2/models/user.dart';

class Home extends StatelessWidget {
  final User _testUser = User(classes: [
    Class(className: "Test Class", classParticipants: [
      Participant(name: "Hector Ramirez", points: 1),
      Participant(name: "Deaz Nunoo", points: 2)
    ])
  ]);

  // ignore: use_key_in_widget_constructors
  Home() {
    Get.put<UserController>(UserController(_testUser));
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: Obx(() {
        logger.i('App has refreshed ${AppController.to.count} times');
        return Row(children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: AllClasses(),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: ClassComponent(),
          ),
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: Column(
              children: [
                Expanded(
                  child: Get.isRegistered<ParticipantController>()
                      ? Obx(
                          () => Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  'Participant Name: ${ParticipantController.to.name}'),
                              Text(
                                  'Participant Points: ${ParticipantController.to.points}'),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StyleizedButton(
                                    color: Colors.green,
                                    text: 'Increment Points',
                                    onTap: () =>
                                        ParticipantController.to.increment(),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  StyleizedButton(
                                      color: Colors.red,
                                      onTap: () =>
                                          ParticipantController.to.decrement(),
                                      text: 'Decrement Points'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  StyleizedButton(
                                      color: Colors.amber,
                                      onTap: () =>
                                          ParticipantController.to.reset(),
                                      text: 'Reset Points')
                                ],
                              )
                            ],
                          ),
                        )
                      : Container(),
                )
              ],
            ),
          )
        ]);
      }));
}
