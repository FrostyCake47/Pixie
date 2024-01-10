import 'package:flutter/material.dart';


class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List<SettingTile> settingTileList = [
    SettingTile(title: "Change password", icon: Icons.password, desc: "Reset your current password", iconColor: Colors.grey[600],),
    SettingTile(title: "About me", icon: Icons.favorite, desc: "Mwaaa my first app", iconColor: Colors.redAccent[400],),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: ListView.builder(itemCount: settingTileList.length ,itemBuilder: (context, index){
        return settingTileList[index];
      }),
    );
  }
}


class SettingTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String desc;
  final Color? iconColor;
  const SettingTile({super.key, required this.title, required this.icon, required this.desc, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListTile(
          tileColor: Colors.black45,
          leading: Icon(icon, color: iconColor,),
          title: Text(title),
          subtitle: Text(desc, style: TextStyle(color: Colors.grey[400])),
        
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
      ),
    );
  }
}