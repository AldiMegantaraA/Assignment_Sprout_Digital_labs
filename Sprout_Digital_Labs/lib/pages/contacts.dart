import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getwidget/getwidget.dart';


class GetUserData extends StatefulWidget {
  const GetUserData({key}) : super(key: key);

  @override
  State<GetUserData> createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;

  bool _showFab = true;
  FloatingActionButtonLocation _fabLocation = FloatingActionButtonLocation.endDocked;



  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(Uri.parse("https://reqres.in/api/users?per_page=12"));
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: 
        Text('Contacts'),
        backgroundColor: Colors.blue[900]
      ),
      body: Scrollbar( isAlwaysShown: true, controller: _scrollController,
        child: FutureBuilder<List<dynamic>>(
          future: _fecthDataUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column( children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: _selectedIndex== index ? Colors.yellow[200] : null,
                            borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          leading: 
                          GFAvatar(
                            borderRadius: BorderRadius.circular(5),
                            backgroundImage:NetworkImage(snapshot.data[index]['avatar']),
                            shape: GFAvatarShape.square
                          ),
                          title: 
                            Text(snapshot.data[index]['first_name'] + " " + snapshot.data[index]['last_name'],
                                style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
                            ),
                          subtitle: 
                            Text(snapshot.data[index]['email'],
                            style: TextStyle(color: Colors.blue[900]),
                            ),
                          trailing: Row( 
                            mainAxisSize: MainAxisSize.min,         
                            children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 6),
                              child:
                                Icon(Icons.phone)),
                                Icon(Icons.chat),
                              Container(
                                margin: EdgeInsets.only(left: 6),
                                child:
                                  Icon(Icons.circle, size: 8, color: index % 2 == 0 ? Colors.green[400] : Colors.red[400],))
                          ]),
                          selected: index == _selectedIndex,
                          onTap: () => setState(() {
                            _selectedIndex = index;
                          }),
                        ),
                    )]);
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: _showFab
            ? FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
                tooltip: 'Create',
              )
            : null,
    );
  }
}
