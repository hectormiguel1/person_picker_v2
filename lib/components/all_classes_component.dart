import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:person_picker_v2/components/styleized_button.dart';
import 'package:person_picker_v2/controllers/user_controller.dart';
import 'package:person_picker_v2/models/class.dart';
import 'package:person_picker_v2/models/participant.dart';

// ignore: use_key_in_widget_constructors
class AllClasses extends StatelessWidget {
  final TextEditingController className = TextEditingController();
  final TextEditingController classParticipants = TextEditingController();
  final ScrollController controller = ScrollController(initialScrollOffset: 0);
  void addClass() => Get.dialog(AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Add New Class'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: className,
                decoration: const InputDecoration(
                    label: Text('Class Name'), hintText: 'Enter class Name')),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: classParticipants,
              maxLines: 4,
              decoration: const InputDecoration(
                  label: Text('Participants'),
                  hintText: 'Enter coma separated participant list.'),
            )
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              UserController.to.addClass(Class(
                  className: className.text,
                  classParticipants: classParticipants.text.isEmpty
                      ? []
                      : classParticipants.text
                          .trim()
                          .split(',')
                          .map((element) => Participant(name: element))
                          .toList()));
              Get.back();
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: Get.back,
          )
        ],
      ));
  @override
  Widget build(BuildContext context) => Get.isRegistered<UserController>()
      ? Obx(
          () => Container(
            color: Colors.white.withOpacity(0.05),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Classes for User'),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        StyleizedButton(
                            color: Colors.green,
                            onTap: addClass,
                            text: 'Add Class'),
                        const SizedBox(
                          width: 10,
                        ),
                        StyleizedButton(
                            color: Colors.red,
                            onTap: () => {},
                            text: 'Remove class'),
                      ])),
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
                            shrinkWrap: false,
                            controller: controller,
                            scrollDirection: Axis.vertical,
                            itemCount: UserController.to.classes.length,
                            itemBuilder: (context, idx) => ListTile(
                                  leading: const Icon(Icons.groups),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: Text(
                                      UserController.to.classes[idx].className),
                                  onTap: () => UserController.to.selectClass(
                                      UserController.to.classes[idx].uid),
                                )),
                      ),
                    ),
                  ),
                ]),
          ),
        )
      : Expanded(
          child: Container(),
        );
}
