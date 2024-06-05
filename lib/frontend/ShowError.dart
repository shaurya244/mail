import 'package:flutter/material.dart';

class ShowError extends StatefulWidget {
  const ShowError({super.key});

  @override
  State<ShowError> createState() => _ShowErrorState();
}

class _ShowErrorState extends State<ShowError> {
    showerror(){ 
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          height: 200,
          width:200,
          child: Center(child: Text('Wrong credentials')),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return showerror();
  }
}