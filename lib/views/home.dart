import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:person_picker_v2/components/all_classes_component.dart';
import 'package:person_picker_v2/components/class_component.dart';
import 'package:person_picker_v2/components/participant_view.dart';
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
            flex: 4,
            fit: FlexFit.tight,
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: ParticipantView(),
                ),
                Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Container(
                      child: Center(
                          child: Text('Space for Groups, To Be Completed.')),
                    ))
              ],
            ),
          )
        ]);
      }));
}
