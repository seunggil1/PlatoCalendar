import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ToDoList();
}

class _ToDoList extends State<ToDoList>{
  BuildContext ctx;
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: 
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                isExpanded: true,
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              flex: 18,
            ),
            Expanded(child: 
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.add_box_outlined),
                  onPressed: () => showMessage('IconButton'),
                ),
              ),
              flex: 6
            ),
            Expanded(child:
              IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () => showMessage('IconButton'),
                ),
              flex: 2
            )
          ],

        )

    ));
  }
      void showMessage(String msg) {
        final snackbar = SnackBar(content: Text(msg));

        Scaffold.of(ctx)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackbar);
    }
}


