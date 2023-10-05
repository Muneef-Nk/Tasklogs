

import 'package:flutter/material.dart';

import '../../model/data_model.dart';
import '../details/details_screen.dart';
// import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController todoController = TextEditingController();


  // var myDb= Hive.box('testBox');



  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController dateController=TextEditingController();


  int isSelectedColor=0;
  Color? selectedColor;

  DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          centerTitle: true,
          title: Text("N O T E", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(context: context, builder: (context){
              DateTime?  dateTime;

              return StatefulBuilder(
                builder: (BuildContext context,  setState){
                  return SizedBox(
                    height: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          padding: EdgeInsets.only(left: 20),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: "Title",
                              border: InputBorder.none
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          padding: EdgeInsets.only(left: 20),
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            controller: descriptionController,
                            decoration: InputDecoration(
                                hintText: "Description",
                                border: InputBorder.none
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.only(left: 20, right: 20),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${selectedDate.year}/${selectedDate.month}/${selectedDate.day}'),
                              GestureDetector(
                                  onTap: ()async {
                                    setState(() async{
                                      DateTime?  dateTime = await showDatePicker(
                                          context: context,
                                          initialDate: selectedDate,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2025)
                                      );
                                      if(dateTime != null){
                                        setState(() {
                                          selectedDate =dateTime!;
                                        });
                                      }
                                    });
                                  },
                                  child: Icon(Icons.calendar_month))
                            ],
                          )

                        ),
                        SizedBox(height: 20,),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text("Select Color : ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                            )),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: SizedBox(
                            height: 20,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                               // shrinkWrap: true,
                               itemCount: color.length,
                                itemBuilder: (context, index){
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectedColor=color[index];
                                    isSelectedColor=index;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: color[index],
                                  child:isSelectedColor== index? Icon(Icons.check, color: Colors.white, size: 13,):null,
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(height: 20,),

                        GestureDetector(
                          onTap: (){
                            setState(() {
                              noteModel.add(NoteModel( description: descriptionController.text, title: titleController.text, color: selectedColor!, dateTime: dateTime));
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),)),
                          ),
                        )
                      ],
                    ),
                  );
                }
              );
            });

          },
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add, size: 35, color: Colors.white,),
        ),

        body: ListView.builder(
            itemCount: noteModel.length,
            itemBuilder: (context, index){
          return  GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailScreen()));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              // height: 100,
              margin: EdgeInsets.only(top: 20, left: 25, right: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: noteModel[index].color,
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListTile(
                    title: Text(noteModel[index].title, style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),),
                    subtitle: Text(noteModel[index].description, style: TextStyle(color: Colors.white),),
                    trailing: Column(
                      children: [
                        IconButton(onPressed: (){
                        },  icon: Icon(Icons.delete, color: Colors.white,)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(noteModel[index].date, style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
          );
        })
    );
  }
}
