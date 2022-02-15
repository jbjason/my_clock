import 'package:flutter/material.dart';

class TitleTextFormField extends StatelessWidget {
  const TitleTextFormField({
    Key? key,
    required TextEditingController titleController,
  })  : _titleController = titleController,
        super(key: key);
  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        //initialValue: title,
        controller: _titleController,
        cursorColor: Colors.red,
        cursorHeight: 15,
        cursorWidth: 5,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: 'Title',
          hintStyle:  TextStyle(color: Colors.grey[700], letterSpacing: 3.5),
          filled: true,
          fillColor: Colors.grey[400],
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
