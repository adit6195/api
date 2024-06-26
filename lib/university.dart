import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class UniversityPage extends StatefulWidget {
  const UniversityPage({super.key});

  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  Map? mapres;
  List? listres;


  Future fechData() async {
    print("fetch data call");
    http.Response response;
    response = await http.get(Uri.parse(
        'http://universities.hipolabs.com/search?country=United+States'));
    print('printing response');
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        listres = json.decode(response.body);
        mapres = listres![0];
      });
      print("Hello");
      print(listres.toString());
      print("HelloUniversity2");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fechData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mapres == null?
            Text("Loading"):
            ListView.builder(
              itemCount: listres!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ("Name: ") +
                                              ("  ") +
                                              listres![index]['name']
                                                  .toString(),
                                        ),
                                        Text(
                                          ("Country: ") +
                                              ("  ") +
                                              listres![index]['country']
                                                  .toString(),
                                        ),
                                        Text(
                                          ("Alpha Two Code: ") +
                                              ("  ") +
                                              listres![index]
                                                      ['alpha_two_code']
                                                  .toString(),
                                        ),
                                        Text(
                                          ("Web Page: ") +
                                              ("  ") +
                                              listres![index]['web_pages']
                                                      [0]
                                                  .toString(),
                                        ),
                                        Text(
                                          ("Domain: ") +
                                              ("  ") +
                                              listres![index]['domains'][0]
                                                  .toString(),
                                        ),
                                        Text(
                                          ("State Province: ") +
                                              ("  ") +
                                              listres![index]
                                                      ['state-province']
                                                  .toString(),
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Divider(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
            })
          ],
        ),
      ),
    );
  }
}