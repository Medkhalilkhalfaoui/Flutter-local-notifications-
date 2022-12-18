import 'package:flutter/material.dart';
import 'package:notification_flutter/SecondPage.dart';
import 'package:notification_flutter/notificationApi.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:get_storage/get_storage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var d = DateTime.now();
  int h = 20;
  int m = 0;
  final box = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenNotifications();
    tz.initializeTimeZones();

    //NotificationApi.showScheduledNotification(scheduledDate: DateTime.now());
  }
  listenNotifications(){
    NotificationApi.onNotification.stream.listen((event) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SecondPage(msg: event,)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const Text("Local",textAlign: TextAlign.start,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            const Text("Notifications",textAlign: TextAlign.start,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            const SizedBox(height: 42,),
            ElevatedButton(
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.white)),
                onPressed: (){
                  NotificationApi.showNotification(
                    title: 'Khalil Abs',
                    body: 'Hey! Do we have everything we need for the lunch',
                    playload: 'khalil.abs'
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: const[
                      Icon(Icons.notifications,color: Colors.black,),
                      SizedBox(width: 20,),
                      Text("Simple Notifications",style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.white)),
              onPressed: (){
                NotificationApi.showScheduledNotification(
                    title: 'promo',
                    body: 'hello khalil',
                    playload: 'hello khalil',

                    scheduledDate: DateTime(d.year,d.month,godhwa(h, m)?d.day+1:d.day,h,m)
                    //DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,6)
                );

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: const[
                    Icon(Icons.notifications_active,color: Colors.black,),
                    SizedBox(width: 20,),
                    Text("Scheduled Notification",style: TextStyle(color: Colors.black),),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.white)),
              onPressed: (){
                NotificationApi.cancel(1);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: const[
                    Icon(Icons.delete_sharp,color: Colors.black,),
                    SizedBox(width: 20,),
                    Text("Remove Notifications",style: TextStyle(color: Colors.black),),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Notification at 8 pm",style: TextStyle(fontWeight: FontWeight.bold),),
                Switch(
                    value: box.read("etat")??false,
                    activeColor: Colors.black,
                    onChanged: (bool value){
                      setState((){});
                      box.write("etat", value);
                      if(box.read("etat")){
                        NotificationApi.showScheduledNotification(
                            title: ' Final World Cup',
                            body: ' Match Argentine Vs France start now ',
                            playload: ' Match Argentine Vs France start now ',

                            scheduledDate: DateTime(d.year,d.month,godhwa(h, m)?d.day+1:d.day,h,m)
                          //DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,6)
                        );
                      }else{
                        NotificationApi.cancel(1);
                      }
                    }
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
  godhwa(int a , int b){
    if(a<d.hour){
      return true;
    }
    if(b<d.minute){
      return true;
    }
    return false;
  }
}
