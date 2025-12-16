import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var appBarHeight = Size.fromHeight(60);

var primaryColor = const Color(0xff57CC99);

getWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

getHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}


class MyAppBar extends StatelessWidget {
   String title;
   final bool showBack;
   MyAppBar({super.key,required this.title,required this.showBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      leadingWidth: 15,
      elevation: 70,
      automaticallyImplyLeading: false,

      title:  Center(child: Text(title,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),)),
    );
  }
}


class MyTexField extends StatelessWidget {
  TextEditingController controller;
  final label,width,height,borderRadius;

  MyTexField({super.key,required this.controller,required this.width,required this.height,required this.borderRadius,required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(double.parse(borderRadius.toString())),
        border: Border.all(
          color: Colors.black54,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        minLines: 1,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        ),
      ),
    );
  }
}

pleaseSelectAlert(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(20),

        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.purple.shade200,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: const Text(
            'Notification',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please select ${text.toLowerCase()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
