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
      inputPass += (index+1).toString();
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
            Icon(Icons.lock, color: Colors.redAccent[400], size: 40,),
            SizedBox(height: 20,),
            Text(inputPass, style: TextStyle(color: Colors.white, fontSize: 20),),
            SizedBox(height: 20,),
            Dialpad(enterPass: enterPass,),
            
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
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          itemCount: 9,
          
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0, // Adjust spacing as needed
            mainAxisSpacing: 8.0,  // Adjust spacing as needed
            childAspectRatio: 4.0 / 2.0,), 
          itemBuilder: (context, index){
            
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26, 
              ),
              
              child: TextButton(
                onPressed: (){
                  widget.enterPass(index);
                }, 
                child: Text((index + 1).toString(), style: const TextStyle(fontSize: 25,color: Colors.white),)),
            );
          }
        ),
      ),
    );
  }
}