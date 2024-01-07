import 'package:flutter/material.dart';


class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  String inputPass = "";

  void enterPass(index){
    setState(() {
      if(inputPass.length >= 4) inputPass = "";
      inputPass += (index).toString();
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
            Icon(Icons.lock, color: Colors.redAccent[400], size: 50,),
            SizedBox(height: 20,),
            Text(inputPass, style: TextStyle(color: Colors.white, fontSize: 20),),
            SizedBox(height: 20,),
            
            Dialpad(enterPass: enterPass,),
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
          mainAxisSpacing: 8.0,  // Adjust spacing as needed
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