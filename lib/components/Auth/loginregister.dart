import 'package:flutter/material.dart';


class TextFields extends StatelessWidget {
  final TextEditingController controller;
  final Function(String, String) editValueOnChange;
  final String str;

  const TextFields({super.key, required this.controller, required this.editValueOnChange, required this.str});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        obscureText: str == "Password" || str == "Confirm Password" ? true : false,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: str,
          hintStyle: const TextStyle(color: Colors.grey)
        ),
        style: const TextStyle(color: Colors.white),
        onChanged: (value){
          editValueOnChange(value, str);
        },
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final Function() action;
  const AuthButton({super.key, required this.text ,required this.action});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
    
        backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 255, 23, 68))
      ),
      onPressed: action, 
      child: Text("   $text   ", style: const TextStyle(color: Colors.white, fontSize: 20),));
  }
}


class ImageButton extends StatelessWidget {
  final String imageURL;
  final Function()? onPressed;
  const ImageButton({super.key, required this.imageURL, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      //child: Image.asset(imageURL, height: 40, width: 40,)
      child: IconButton(icon: Container(child: Image.asset(imageURL), height: 40, width: 40,), onPressed: () => onPressed)
    );
  }
}