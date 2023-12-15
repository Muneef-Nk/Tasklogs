import 'package:flutter/material.dart';

class NotesCard extends StatefulWidget {
  const NotesCard({
    super.key,
    required this.isGrid,
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
  final bool isGrid;
  final Function() onDelete;

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      padding: EdgeInsets.all(10),
      margin: widget.isGrid
          ? EdgeInsets.only(bottom: 20, left: 10, right: 10)
          : null,
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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.des,
                  style: TextStyle(color: Colors.white),
                  maxLines: widget.isGrid ? 3 : 8,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            trailing: widget.isGrid
                ? Column(
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
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5, top: 20),
            child: Text(
              widget.date,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
