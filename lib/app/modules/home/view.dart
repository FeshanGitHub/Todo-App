import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import 'package:todoapp/app/data/models/task.dart';
import 'package:todoapp/app/modules/home/controller.dart';
import 'package:todoapp/app/modules/home/widgets/add_card.dart';
import 'package:todoapp/app/modules/home/widgets/add_dialog.dart';
import 'package:todoapp/app/modules/home/widgets/task_card.dart';

import '../report/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Obx(() => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Text(
                      "My Todo List",
                      style: TextStyle(
                          fontSize: 24.0.sp, fontFamily: 'Rowdies-Light'),
                    ),
                  ),
                  Obx(
                        () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map((element) => LongPressDraggable(
                            data: element,
                            onDragStarted: () =>
                                controller.changeDeleting(true),
                            onDraggableCanceled: (_, __) =>
                                controller.changeDeleting(false),
                            onDragEnd: (_) =>
                                controller.changeDeleting(false),
                            feedback: Opacity(
                              opacity: 0.8,
                              child: TaskCard(task: element),
                            ),
                            child: TaskCard(task: element)))
                            .toList(),
                        AddCard()
                      ],
                    ),
                  ),
                ],
              ),
            ),
             ReportScreen(),
          ],
        ),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(
          () => Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              onTap: (int index) => controller.changeTabIndex(index),
              currentIndex: controller.tabIndex.value,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Colors.pinkAccent.withOpacity(0.8),
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Padding(
                    padding: EdgeInsets.only(right: 18.0.wp),
                    child: const Icon(Icons.apps),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Report',
                  icon: Padding(
                    padding: EdgeInsets.only(
                      left: 18.0.wp,
                    ),
                    child: const Icon(Icons.data_usage),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: DragTarget<Task>(onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Success');
        }, builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor: controller.deleting.value
                  ? Colors.red
                  : Colors.pinkAccent.withOpacity(0.85),
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(() => AddDialog(), transition: Transition.downToUp);
                } else {
                  EasyLoading.showInfo('Please create your task type');
                }
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        }));
  }
}
