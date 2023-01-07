import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import 'package:todoapp/app/modules/home/controller.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() {
        var createdTasks = homeCtrl.getTotalTask();
        var completedTasks = homeCtrl.getTotalDoneTask();
        var liveTasks = createdTasks - completedTasks;
        var percent = (completedTasks / createdTasks * 100).toStringAsFixed(0);
        return Padding(
          padding: EdgeInsets.only(
            left: 4.0.wp,
            top: 2.0.hp,
            right: 4.0.wp,
          ),
          child: ListView(
            children: [
              Text(
                "My Report",
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontFamily: 'Rowdies-Light',
                ),
              ),
              SizedBox(
                height: 2.0.hp,
              ),
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                  fontFamily: 'Rowdies-Light',
                ),
              ),
              SizedBox(
                height: 2.0.hp,
              ),
              const Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 4.0.hp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatus(Colors.green, liveTasks != 0 ? liveTasks : 0, 'Live Task'),
                  _buildStatus(Colors.orange,completedTasks != 0 ?  completedTasks : 0, 'Completed '),
                  _buildStatus(Colors.blue, createdTasks != 0 ?  createdTasks : 0, 'Created'),
                ],
              ),
              SizedBox(
                height: 4.0.hp,
              ),
              UnconstrainedBox(
                child: SizedBox(
                  width: 70.0.wp,
                  height: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: createdTasks == 0 ? 1 : createdTasks,
                    currentStep: completedTasks,
                    unselectedColor: Colors.grey.withOpacity(0.3),
                    stepSize: 20,
                    selectedColor: Colors.pinkAccent.withOpacity(0.85),
                    padding: 0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 22,
                    roundedCap: (_, __) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${createdTasks == 0 ? 0 : percent} %',
                          style: TextStyle(
                            fontSize: 12.0.wp,
                            fontFamily: 'Rowdies-Light',
                            color: Colors.pinkAccent.withOpacity(
                              0.85,
                            ),
                          ),
                        ),
                        Text(
                          'Efficiency',
                          style: TextStyle(
                            fontSize: 7.0.wp,
                            fontFamily: 'Rowdies-Light',
                            color: Colors.pinkAccent.withOpacity(
                              0.85,
                            ),
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
      })),
    );
  }

  _buildStatus(Color color, int number, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.5.wp, color: color),
          ),
        ),
        SizedBox(
          width: 3.0.wp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: TextStyle(
                fontFamily: 'Rowdies-Light',
                fontSize: 16.0.sp,
              ),
            ),
            SizedBox(
              height: 2.0.wp,
            ),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'Rowdies-Light',
                  fontSize: 12.0.sp,
                  color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
