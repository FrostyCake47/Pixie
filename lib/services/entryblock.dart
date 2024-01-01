import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

part 'entryblock.g.dart';


@HiveType(typeId: 1)
class EntryBlockDetails{
  @HiveField(0)
  late final int id;

  @HiveField(1)
  late final String title;

  @HiveField(2)
  late final String subtitle;

  @HiveField(3)
  late final String date;

  @HiveField(4)
  late final String time;

  @HiveField(5)
  late final String day;

  @HiveField(6)
  late final String content;

  EntryBlockDetails({Key? key, required this.id, required this.title, required this.subtitle});
}

class EntryBlock extends StatelessWidget {
  final EntryBlockDetails? instance;
  final BuildContext parentContext;

  void createTime(){
    print("called createTime()");
    DateTime now = DateTime.now();
    instance?.date = DateFormat('d MMM').format(now);
    instance?.time = DateFormat.jm().format(now).toString();
    instance?.day = DateFormat.E('en_US').format(now);
    instance?.content = "";
    print(instance?.day);
  }


  EntryBlock({Key? key, required this.instance, required this.parentContext}): super(key: key){
    print(instance?.title);
    print("EntryBlock constructor");

    try {
      print(instance?.date);
    } 
    catch (e) {
      print("called creatTime()");
      createTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey[900],
      ),
      
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(), 
          children: [
            SlidableAction(onPressed: (parentContext){

            }, 
            
            icon: Icons.delete_forever,)]),

        child: ListTile(
          title: Text(instance?.title ?? "title"),
          subtitle: Text(instance?.subtitle ?? "subtitle"),
          trailing: Column(
            children: [
              Text(instance?.date ?? "date"),
              Expanded(child: IconButton(icon: Icon(Icons.delete), color: Colors.white, onPressed: (){},))
            ],
          ),
          
          tileColor: Colors.grey[900],
        
          onTap: () async {
            await Navigator.pushNamed(context, '/entry', arguments: {
              'title': instance?.title ?? "title", 
              'subtitle': instance?.subtitle ?? "subtitle", 
              'date': instance?.date ?? "date", 
              'time': instance?.time ?? "time",
              'day' : instance?.day ?? "day",
              'id' : instance?.id ?? "id",
              'content' : instance?.content ?? "content",
            });
          },
          
          titleTextStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.grey,
          ),
          leadingAndTrailingTextStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
