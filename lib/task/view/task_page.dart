import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/task/controller/task_controller.dart';
import 'package:task/task/widgets/left_flow.dart';

import '../widgets/right_flow.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = Get.put(TaskController());

    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Vimigo',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Container(
              width: 25,
              height: 25,
              margin: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://bidinnovacion.org/economiacreativa/wp-content/uploads/2014/10/speaker-3.jpg"))),
            )
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Column(
                children: [
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Select Content',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: List.generate(
                        task.contents.length,
                        (index) => DropdownMenuItem<String>(
                              value: jsonEncode(task.contents()[index]),
                              child: Text(
                                task.contents()[index]['content']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            )),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select content.';
                      }
                      return null;
                    },
                    onChanged: (value) => task.setContents(value),
                    onSaved: (value) {},
                    buttonStyleData: const ButtonStyleData(
                      height: 60,
                      padding: EdgeInsets.only(left: 20, right: 10),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: task.scrollController(),
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: List.generate(
                          task.contents.length,
                          (index) {
                            int current = int.parse(task.currentContents['id'] ?? '-1');
                            int from = int.parse(task.contents[index]['id']!);
                            bool isSelected = current >= from;
                            if (!task.isOdd("$index")) {
                              return RightFlow(
                                onTap: () => isSelected ? _showModal(content: task.contents[index]['content']!) : null,
                                text: task.contents[index]['content']!,
                                isSelected: isSelected,
                              );
                            }
                            return LeftFLow(
                              onTap: () => isSelected ? _showModal(content: task.contents[index]['content']!) : null,
                              text: task.contents[index]['content']!,
                              isSelected: isSelected,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 15,
                borderRadius: BorderRadius.circular(25),
                shadowColor: Colors.black,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.bounceInOut,
                  height: task.displayModal() ? 7.h : 0,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      if (task.displayModal())
                        Container(
                          width: 50.w,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 85, 77, 77),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Future<void> _showModal({required String content}) {
    return showModalBottomSheet<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50.w,
                height: 5,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 85, 77, 77),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              SizedBox(height: 3.h),
              Text(content),
            ],
          ),
        );
      },
    );
  }
}
