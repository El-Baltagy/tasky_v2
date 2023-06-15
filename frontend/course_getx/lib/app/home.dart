import 'package:course_getx/app/notes/edit.dart';
import 'package:course_getx/components/cardnote.dart';
import 'package:course_getx/components/crud.dart';
import 'package:course_getx/constant/linkapi.dart';
import 'package:course_getx/main.dart';
import 'package:course_getx/model/notemodel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  bool isLoading = false;

  getNotes() async {
    var response =
        await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  FutureBuilder(
                      future: getNotes(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data['status'] == 'fail')
                            return Center(
                                child: Text(
                              "لا يوجد ملاحظات",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ));
                          return ListView.builder(
                              itemCount: snapshot.data['data'].length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return CardNotes(
                                  onDelete: () async {
                                    var response = await postRequest(
                                        linkDeleteNotes, {
                                      "id": snapshot.data['data'][i]['notes_id'].toString() , 
                                      "imagename" : snapshot.data['data'][i]['notes_image'].toString() 
                                    });
                                    if (response['status'] == "success") {
                                      Navigator.of(context)
                                          .pushReplacementNamed("home");
                                    }
                                  },
                                  ontap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => EditNotes(
                                                notes: snapshot.data['data']
                                                    [i])));
                                  },
                                  notemodel: NoteModel.fromJson(snapshot.data['data'][i])
                                );
                              });
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: Text("Loading ..."));
                        }
                        return Center(child: Text("Loading ..."));
                      })
                ],
              ),
            ),
    );
  }
}
