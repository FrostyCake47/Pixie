import 'package:flutter/material.dart';


class Pixie extends StatelessWidget {
  final String text = "Pixie";
  final TextStyle? style = const TextStyle(
          fontFamily: "LavishlyYours", 
          fontSize: 96,      
          );
          
  Gradient gradient = LinearGradient(
    colors: [
      Colors.redAccent.shade400,
      Colors.purple.shade600,],
    
    begin: const Alignment(0, -1),
    end : const Alignment(0, 0)
    );

  Pixie({
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 30, bounds.width, bounds.height),
      ),
      child: Text(text, 
        style: style,),
    );
  }
}
