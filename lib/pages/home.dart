
import 'dart:io' show Platform;
import 'dart:math';
import 'package:brand_name2/models/band_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<Band> _bands =[
    new Band(name: 'Metallica', id: '1', votes: 1),
    new Band(name: 'Moderato', id: '2', votes: 2),
    new Band(name: 'Iron maiden', id: '3', votes: 2),
    new Band(name: 'Kimiwa', id: '4', votes: 5),
  ];

  TextEditingController addBandTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text('Band names', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _bands.length,
        itemBuilder: (context, i)=>listTileBand(_bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: ()=>addNewBand(context),

      ),
    );
    
  }

  Widget listTileBand(Band band){
    //Cuando lo jiras a la derecha se borra
    return Dismissible(
      //El tipo key es como un valor unico
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 8),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child:  Text('Delete band', style: TextStyle(color:Colors.white),),
        ),
      ),
      onDismissed: (direction){
        print('direction $direction');
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[200],
          child: Text(band.name.substring(0,2),style: TextStyle(color: Colors.blueAccent,fontSize: 21),),
        ),
        title: Text(band.name,style: TextStyle(fontSize: 19, color: Colors.black),),
        trailing: Text(band.votes.toString(),style: TextStyle(fontSize: 21, color: Colors.black, ),),
        onTap:(){
          print(band.name);
        },
      ),
    );
  }

  void addNewBand(BuildContext context){
    if(Platform.isAndroid){
      showDialog(
        context: context, 
        builder: ( context)=>AlertDialog(
          title: Text('New band'),
          content: TextField(
            controller: addBandTextController ,
          ),
          //Es el boton
          actions: [
            MaterialButton(
              child: Text('Add'),
              elevation: 5,
              color: Colors.blue,
              onPressed: ()=>addBandToList(addBandTextController.text),
            )
          ],
        )
      );
    }else showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('New band'),
        content: TextField(
          controller: addBandTextController ,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Add'),
            onPressed: () => addBandToList(addBandTextController.text),
          )
        ]
      )
    );
    
  }

  void addBandToList(String name){
    if(name.length>1){
      _bands.add( new Band(id: DateTime.now().toString(),name: name,votes:0));
      addBandTextController.text='';
      setState(() {});
    }
    Navigator.of(context).pop(true);
  }
  
}