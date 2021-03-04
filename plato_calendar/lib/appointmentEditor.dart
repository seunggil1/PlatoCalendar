import 'package:flutter/material.dart';
import 'package:plato_calendar/Data/else.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'Data/userData.dart' as userData;
import 'ics.dart';

class PopUpAppointmentEditor extends StatefulWidget{
  CalendarData calendarData;

  CalendarData get scalendarData => calendarData;
  PopUpAppointmentEditor.appointment(Appointment data){
    calendarData = userData.data.firstWhere((value) {
      return value.hashCode == data.resourceIds[0];
    });
  }
  PopUpAppointmentEditor(this.calendarData);

  @override
  _PopUpAppointmentEditorState createState() => _PopUpAppointmentEditorState();
}
class _PopUpAppointmentEditorState extends State<PopUpAppointmentEditor>{
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.text = widget.calendarData.description;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 50,
                    child: FlatButton(padding: EdgeInsets.all(5),onPressed: (){print(1);}, child: Icon(Icons.delete_outlined, color: Colors.white,)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 50,
                    child: FlatButton(padding: EdgeInsets.all(5),onPressed: (){print(1);}, child: Text('완료',style: TextStyle(color: Colors.white),)),
                  )
                ],
              ),
              ),
            backgroundColor: colorCollection[widget.calendarData.color],
          ),
          body: Container(
            child: Column(
              children: [
                TextField(
                  controller: myController,
                ),
                Text(widget.calendarData.className == "" ? widget.calendarData.classCode : widget.calendarData.className),
                Text(widget.calendarData.summary),
                Text(widget.calendarData.description),
                Text(widget.calendarData.start.toString()),
                Text(widget.calendarData.end.toString()),
                FlatButton(child: Text("1"),
                  onPressed: (){
                    showDialog(context: context,
                      builder: (BuildContext context){
                        return CalendarColorPicker(
                          colorCollection,widget.calendarData);
                        
                      }).then((value) => setState((){
                        
                      }));
                  })
              ],
            ),
          ),
    );
  }

}
class CalendarColorPicker extends StatefulWidget {
  CalendarColorPicker(this.colorCollection, this.test);

  final List<Color> colorCollection;
  final CalendarData test;

  @override
  State<StatefulWidget> createState() => _CalendarColorPickerState();
}

class _CalendarColorPickerState extends State<CalendarColorPicker> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding : const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 24.0),
        content: Container(
          alignment: Alignment.center,
          width: (widget.colorCollection.length * 100).toDouble(),
          height: 50.0,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0),
            leading: Text('색상',style: TextStyle(fontWeight: FontWeight.bold),),
            title: ListView.builder(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              itemCount: widget.colorCollection.length,
              itemBuilder: (context,i){
                return FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.all(5),
                  minWidth: 10,
                  onPressed: (){
                    setState(() {
                      widget.test.color = i;
                    });
                    Future.delayed(const Duration(milliseconds: 200), () {
                      Navigator.pop(context);
                    });
                  },
                  child: Icon(
                    i == widget.test.color
                        ? Icons.lens
                        : Icons.trip_origin,
                    color: widget.colorCollection[i])
                  );
              }),
          )

    ));
  }
}