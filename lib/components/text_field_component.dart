import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final bool? check;
  final String? title;
  final Function()? function;
  const ButtonComponent({Key? key, this.check, this.title, this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(5),
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: check == false
          ? Center(
              child: Text(
                title!,
                // style: GoogleFonts.quicksand(
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //     letterSpacing: 2),
              ),
            )
          : const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyan,
              ),
            ),
    );
  }
}
