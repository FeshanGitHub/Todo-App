import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import '../../home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
          ? Column(
              children: [
                SizedBox(height: 2.0.hp,),
                Image.asset(
                  'assets/images/task.png',
                  fit: BoxFit.cover,
                  width: 40.0.wp,
                ),
                Text(
                  'No Task Available',
                  style: TextStyle(
                    wordSpacing: 2,
                    fontSize: 16.0.sp,
                    color: Colors.pinkAccent.withOpacity(0.7),
                    fontFamily: 'Rowdies-Light',
                  ),
                ),
              ],
            )
          : ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ...homeCtrl.doingTodos.map((element) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2.5.wp,horizontal: 8.5.wp),
            child: Row(
              children: [
                 SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(fillColor: MaterialStateProperty.resolveWith((states) => Colors.grey),value: element['done'],onChanged: (value){
                    homeCtrl.doneTodo(element['title']);
                  },),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
                  child: Text(element['title'],overflow: TextOverflow.ellipsis,),
                )
              ],
            ),
          )).toList(),
          if(homeCtrl.doingTodos.isNotEmpty)
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: const Divider(thickness: 2,),
            )
        ],
      ),
    );
  }
}
