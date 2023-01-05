import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import 'package:todoapp/app/modules/home/controller.dart';

import '../../../core/values/colors.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doneTodos.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0.wp,horizontal: 8.5.wp,),
                child: Text(
                  'Completed (${homeCtrl.doneTodos.length})',
                  style: TextStyle(
                    fontFamily: 'Rowdies-Light',
                    fontSize: 13.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...homeCtrl.doneTodos.map((element) => Dismissible(
                key: ObjectKey(element),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => homeCtrl.deleteDoneTodo(element),
                background: Container(
                  color: Colors.red.withOpacity(0.8),
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 5.0.wp),
                    child: const Icon(Icons.delete,color: Colors.white,),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0.wp,horizontal: 8.5.wp,),
                  child: Row(
                    children: [
                      const SizedBox(width: 20,height: 20,child: Icon(Icons.done,color: blue,),),
                      SizedBox(width: 4.0.wp,),
                      Text(element['title'],overflow: TextOverflow.ellipsis,style: const TextStyle(decoration: TextDecoration.lineThrough),)
                    ],
                  ),
                ),
              )).toList()
            ],
          )
        : Container());
  }
}
