// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:person_picker_v2/components/styleized_button.dart';
import 'package:person_picker_v2/controllers/participant_controller.dart';

class ParticipantView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Get.isRegistered<ParticipantController>()
          ? Obx(() => Container(
              color: Colors.white.withOpacity(0.05),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Participant Name: ${ParticipantController.to.name}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Participant Points: ${ParticipantController.to.points}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StyleizedButton(
                            color: Colors.green,
                            onTap: () => ParticipantController.to.increment(),
                            text: '+1 Point'),
                        const SizedBox(width: 10),
                        StyleizedButton(
                            color: Colors.red,
                            onTap: () => ParticipantController.to.decrement(),
                            text: '-1 Point'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StyleizedButton(
                        color: Colors.orange,
                        onTap: () => ParticipantController.to.reset(),
                        text: 'Reset ${ParticipantController.to.name} Points')
                  ])))
          : Container();
}
