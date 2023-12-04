import 'package:flutter/material.dart';

class ToggleButtonWidget extends StatefulWidget {
  const ToggleButtonWidget({Key? key}) : super(key: key);

  @override
  State<ToggleButtonWidget> createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {

  final double width = 250;
  bool isOnLeft = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => setState(() {
          isOnLeft = !isOnLeft;
        }),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: isOnLeft ? Colors.grey.shade400 : Colors.blueAccent,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              height: 50,
              width: width,
              alignment: Alignment.center,
              child: Text(
                isOnLeft ? 'Mark as read' : "Marked as read" ,
                style: TextStyle(
                  color: isOnLeft ? Colors.black : Colors.white,
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: 0,
              bottom: 0,
              left: isOnLeft ? 8 : width - 43,
              child: Center(
                child: Container(
                  height: 35,
                  width: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child:  Icon(isOnLeft ? Icons.visibility : Icons.check),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
