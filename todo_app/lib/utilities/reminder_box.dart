import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart';

import 'send_notification.dart';

DateTime scheduleTime = DateTime.now();

class ReminderBox extends StatefulWidget {
  final String taskName; // taskName parametresi eklendi

  ReminderBox({Key? key, required this.taskName}) : super(key: key);

  @override
  State<ReminderBox> createState() => _ReminderBoxState();
}

class _ReminderBoxState extends State<ReminderBox> {

  @override
  void initState() {
    scheduleTime = DateTime.now();
    SendNotification().initNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.pink[300],
      content: Container(
        padding: EdgeInsets.all(35),
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Date & Time:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              child: Text(
                '${scheduleTime.day}/${scheduleTime.month}/${scheduleTime.year} ${scheduleTime.hour}:${scheduleTime.minute}',
              ),
              onPressed: () async {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onChanged: (date) => setState(() => scheduleTime = date),
                  onConfirm: (date) {
                     setState(() => scheduleTime = date);
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                SendNotification().scheduleNotification(
                    title: 'To Do', 
                    body: 'It\'s time to do your task: ${widget.taskName}',
                    payLoad: "this is a schedule data",
                    scheduledNotificationDateTime: scheduleTime,
                );
                Navigator.of(context).pop();},
              child: Text('SET REMINDER', style: TextStyle(fontWeight: FontWeight.bold),),
           ),
          ],
        ),
      ),
    );
  }
}
