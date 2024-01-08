import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';


class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  String inputPass = "";
  late Box<String> passlocker;
  late String password;
  late String displaytext;

  @override
  void initState() {
    super.initState();
    initializePassLock();
  }

  void initializePassLock() {
    passlocker = Hive.box<String>('passlock');
    password = passlocker.get(0) ?? "null";
    if(password == "null") {
      displaytext = "Create new Password";
    } else {
      displaytext = "Enter password";
    }
  }

  void authenticate(){
    if(password == "null"){
      passlocker.put(0, inputPass);
      print("created new pass");
      Navigator.pushNamed(context, "/home");
    }
    else if(inputPass == password){
      Navigator.pushNamed(context, "/home");
      print("correct password");
    }
    else if(inputPass != password){
      String temp = displaytext;
      print("incorrect password");
      setState(() {
        displaytext = "incorrect password";
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          displaytext = temp;
        });
      });
      
    }
  }

  void enterPass(index){
    setState(() {
      if(index == -2) {
        authenticate();
        return;
      }
      if(inputPass.length >= 4) inputPass = "";
      if(index == -1 && int.tryParse(inputPass) != null && inputPass.isNotEmpty) {inputPass = inputPass.substring(0, inputPass.length -1);}
      else{inputPass += (index).toString();}
      if(inputPass == "-1") inputPass = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40,),
            Icon(Icons.lock, color: Colors.redAccent[400], size: 50,),
            const SizedBox(height: 20,),
            Text(displaytext, style: TextStyle(color: Colors.white, fontSize: 20),),
            Text(inputPass, style: TextStyle(color: Colors.white, fontSize: 20),),
            const SizedBox(height: 20,),
            Wrap(
              spacing: 15,
              children: [
                Icon(DiamondIcon.diamonds, color: inputPass.length > 0 ? Colors.redAccent[400] :Colors.white, size: 40,),
                Icon(DiamondIcon.diamonds, color: inputPass.length > 1 ? Colors.redAccent[400] :Colors.white,size: 40,),
                Icon(DiamondIcon.diamonds, color: inputPass.length > 2 ? Colors.redAccent[400] :Colors.white,size: 40,),
                Icon(DiamondIcon.diamonds, color: inputPass.length > 3 ? Colors.redAccent[400] :Colors.white,size: 40,),

              ],
            ),
            SizedBox(height: 40,),
            Dialpad(enterPass: enterPass,),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DialButtons(enterPass: enterPass, value: -1, displayicon: Icons.backspace_outlined,),
                  DialButtons(enterPass: enterPass, value: 0, displayicon: Icons.exposure_zero,),
                  DialButtons(enterPass: enterPass, value: -2, displayicon: Icons.check,),
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}


class Dialpad extends StatefulWidget {
  final void Function(int) enterPass;

  const Dialpad({super.key, required this.enterPass});

  @override
  _DialpadState createState() => _DialpadState();
}

class _DialpadState extends State<Dialpad> { // Store the input numbers

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: 195.0, // Set your desired maximum height
        ),
      //color: Colors.redAccent,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        itemCount: 9,
        
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0, // Adjust spacing as needed
          mainAxisSpacing: 10.0,  // Adjust spacing as needed
          childAspectRatio: 4.0 / 2.0,
          ), 
        itemBuilder: (context, index){
          
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26, 
            ),
            
            child: TextButton(
              onPressed: (){
                widget.enterPass(index+1);
              }, 
              child: Text((index + 1).toString(), style: const TextStyle(fontSize: 25,color: Colors.white),)),
          );
        }
      ),
    );
  }
}

class DialButtons extends StatelessWidget {
  final void Function(int) enterPass;
  final int value;
  final IconData displayicon;
  const DialButtons({super.key, required this.enterPass, required this.value, required this.displayicon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black26, 
      ),
      
      child: TextButton(
        onPressed: (){
          enterPass(value);
        }, 
        //child: Text((value).toString(), style: const TextStyle(fontSize: 25,color: Colors.white),)),
        child: Icon(displayicon, color: value == 0 ? Colors.white : Colors.redAccent[400], size: value == 0 ? 35 : 30,)
      ),
    );
  }
}



class DiamondIcon {
  DiamondIcon._();

  static const _kFontFam = 'DiamondIcon';
  static const String? _kFontPkg = null;

  static const IconData diamonds = IconData(0xe994, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}