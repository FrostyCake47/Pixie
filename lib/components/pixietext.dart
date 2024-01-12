import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';


class Pixie extends StatelessWidget {
  final String text = "Pixie";
  double sizey;
  TextStyle? style;
        
  Gradient gradient = LinearGradient(
    colors: [
      Colors.redAccent.shade400,
      Colors.purple.shade600,],
    
    begin: const Alignment(0, -1),
    end : const Alignment(0, 0)
    );

  Pixie({
    super.key, this.sizey = 96
  });
  
  @override
  Widget build(BuildContext context) {
    style = TextStyle(
      fontFamily: "LavishlyYours", 
      fontSize: sizey,      
    );

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 30, bounds.width, bounds.height),
      ),
      child: GlowText(text, 
        style: style,
        //glowColor: Colors.white,
        blurRadius: 20,),
    );
  }
}
