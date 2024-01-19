import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:diary/components/pixietext.dart';


class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  String inputPass = "";
  String resetText = "Reset password";
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
      //print("created new pass");
      Navigator.pushNamed(context, "/home");
    }
    else if(inputPass == password){
      Navigator.pushNamed(context, "/home");
      //print("correct password");
    }
    else if(inputPass != password){
      String temp = displaytext;
      //print("incorrect password");
      setState(() {
        displaytext = "incorrect password";
        inputPass = "";
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          displaytext = temp;
        });
      });
      
    }
  }

  void resetPassword(){
    passlocker.clear();
  }

  void enterPass(index){
    print(index);
    setState(() {
      if(index == 12) {
        authenticate();
        return;
      }
      if(inputPass.length >= 4) setState(() {inputPass = "";});
      if(index == 10) {(inputPass.length <= 1) ? inputPass = "" :  inputPass = (int.parse(inputPass)%10).toString(); }
      else if(index == 11) {inputPass += "0";}
      else{inputPass += (index).toString();}
      if(inputPass == "-1") inputPass = "";
      //if(inputPass.length == 4){authenticate(); return;}

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
            const SizedBox(height: 20,),

            Expanded(flex: 7, child: Pixie()),
            //const SizedBox(height: 20,),
            Expanded(flex: 2, child: Text(displaytext, style: TextStyle(color: Colors.white, fontSize: 20,),)),

            //const SizedBox(height: 20,),
            Expanded(
              flex: 3,
              child: Wrap(
                spacing: 15,
                children: [
                  GlowIcon(DiamondIcon.diamonds, color: inputPass.length > 0 ? Colors.redAccent[400] :Colors.white, size: 40, blurRadius: inputPass.length > 0 ? 15 : 0,),
                  GlowIcon(DiamondIcon.diamonds, color: inputPass.length > 1 ? Colors.redAccent[400] :Colors.white,size: 40, blurRadius: inputPass.length > 1 ? 15 : 0,),
                  GlowIcon(DiamondIcon.diamonds, color: inputPass.length > 2 ? Colors.redAccent[400] :Colors.white,size: 40, blurRadius: inputPass.length > 2 ? 15 : 0,),
                  GlowIcon(DiamondIcon.diamonds, color: inputPass.length > 3 ? Colors.redAccent[400] :Colors.white,size: 40, blurRadius: inputPass.length > 3 ? 15 : 0,),
                ],
              ),
            ),
            //SizedBox(height: 40,),
            Expanded(flex: 10, child: Dialpad(enterPass: enterPass,)),
            //SizedBox(height: 5,),

            //const SizedBox(height: 20,),
            Expanded(
              flex: 4,
              child: TextButton(
                onPressed: (){setState(() {
                  resetPassword(); 
                  password = "null"; 
                  resetText = "password has been reset\nEnter new password";
                  });
                }, 
                child: Text(resetText,textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)),
            ),
            
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
      // ignore: prefer_const_constructors
      constraints: BoxConstraints(
          maxHeight: 270.0,
        ),
      //color: Colors.redAccent,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        itemCount: 12,
        
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

              child: (index < 9 ) ? Text((index + 1).toString(), style: const TextStyle(fontSize: 25,color: Colors.white),) : 
              (index == 9 ? const Icon(Icons.backspace_outlined, color: Colors.redAccent) : (
               index == 10 ? Text((0).toString(), style: const TextStyle(fontSize: 25,color: Colors.white),) : 
               const Icon(Icons.check, color: Colors.redAccent)
              )
              )
            )

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