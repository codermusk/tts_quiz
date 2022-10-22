import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.elevation = 2.0,
  }) : super(key: key);
  final Widget? title;
  final Widget? leading;
  final double elevation;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 2.5,
            stops: [
              0.0,
              0.27,
              1.0,
            ],
            colors: [
              Color(0XFFB71731),
              Color(0XFFB71731),
              Color(0XFFA5004E),
            ],
          ),
        ),
        child: AppBar(


          elevation: 0.0,
          title: Text('Speech to Text Quizz' ,style: TextStyle(color: Colors.black87  , fontWeight:FontWeight.bold),),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          actions: actions,

        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}