import 'package:flutter/material.dart';

class NotesCard extends StatefulWidget {
  const NotesCard({
    super.key,
    required this.index,
    required this.title,
    required this.des,
    required this.date,
    required this.color,
    required this.onDelete,
  });

  final int index;
  final String title;
  final String des;
  final String date;
  final Color color;
  final Function() onDelete;

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 20, left: 25, right: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                widget.des,
                style: TextStyle(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        widget.onDelete();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Text(
                widget.date,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
