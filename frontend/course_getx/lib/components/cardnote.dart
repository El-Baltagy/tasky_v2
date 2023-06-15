import 'package:course_getx/constant/linkapi.dart';
import 'package:course_getx/model/notemodel.dart';
import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function() ontap;
  final NoteModel  notemodel ; 
  final void Function()? onDelete;
  const CardNotes(
      {Key? key,
      required this.ontap,
      required this.notemodel , 
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoot/${notemodel.notesImage}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${notemodel.notesTitle}"),
                  subtitle: Text("${notemodel.notesContent}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
