import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:person_picker_v2/components/styleized_button.dart';
import 'package:person_picker_v2/controllers/class_controller.dart';
import 'package:person_picker_v2/models/participant.dart';

// ignore: use_key_in_widget_constructors
class ClassComponent extends StatelessWidget {
  final ScrollController controller = ScrollController(initialScrollOffset: 0);
  final Random _rng = Random.secure();
  final TextEditingController participantName = TextEditingController();
  final TextEditingController initialPoints = TextEditingController();

  void addParticipant() => Get.dialog(AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Add Participant'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: participantName,
                decoration: const InputDecoration(
                    label: Text('Participant Name'),
                    hintText: 'Enter participant name')),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: initialPoints,
                decoration: const InputDecoration(
                    label: Text('Initial Points'),
                    hintText: 'Enter initial points, defaults to 0 if empty'))
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              ClassController.to.addParticipant(Participant(
                  name: participantName.text,
                  points: initialPoints.text.isEmpty
                      ? 0
                      : int.parse(initialPoints.text)));
              Get.back();
            },
          ),
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            onPressed: Get.back,
          )
        ],
      ));

  void pickRandom() => ClassController.to.selectParticipant(ClassController
      .to
      .participants[(_rng.nextInt(ClassController.to.participants.length))]
      .uid);

  @override
  Widget build(BuildContext context) => Get.isRegistered<ClassController>()
      ? Obx(() => Container(
            color: Colors.white.withOpacity(0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text('Participants for ${ClassController.to.className}'),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            StyleizedButton(
                                color: Colors.green,
                                onTap: addParticipant,
                                text: 'Add Participant'),
                            const SizedBox(
                              width: 10,
                            ),
                            StyleizedButton(
                                color: Colors.red,
                                onTap: () => {},
                                text: 'Remove Participant'),
                            const SizedBox(width: 10),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            StyleizedButton(
                                color: Colors.blue,
                                onTap: pickRandom,
                                text: 'Pack at Random')
                          ],
                        )
                      ],
                    )),
                Flexible(
                  flex: 10,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.15)),
                      child: ListView.builder(
                        controller: controller,
                        itemCount: ClassController.to.participants.length,
                        itemBuilder: (context, idx) => ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          leading: const Icon(Icons.account_circle),
                          title:
                              Text(ClassController.to.participants[idx].name),
                          onTap: () => ClassController.to.selectParticipant(
                              ClassController.to.participants[idx].uid),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))
      : Container();
}
