import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final bool? check;
  final String? title;
  final IconData? icon;
  final Function()? function;
  const ButtonComponent(
      {Key? key, this.check, this.title, this.function, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(5),
        backgroundColor: MaterialStateProperty.all(const Color(0XFF46A186)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: check == false
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title!,
                    // style: GoogleFonts.quicksand(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //     letterSpacing: 2),
                  ),
                  Icon(icon),
                ],
              ),
            )
          : const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
    );
  }
}
