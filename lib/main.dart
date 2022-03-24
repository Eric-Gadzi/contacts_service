import "package:contacts_service/contacts_service.dart";
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(ContactViewer());
}

class ContactViewer extends StatefulWidget {
  const ContactViewer({Key? key}) : super(key: key);

  @override
  State<ContactViewer> createState() => _ContactViewerState();
}

class _ContactViewerState extends State<ContactViewer> {
  List<Contact> contacts = [];

  //what is the initState
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    getContacts();
  }

  //what does it mean to have async and why for this function
  void getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      List<Contact> _contacts =
          await ContactsService.getContacts(withThumbnails: false);
      setState(() {
        contacts = _contacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Text Of Contacts"),
        centerTitle: true,
        elevation: 0.50,
      ),
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              Contact contact = contacts[index];

              return ListTile(
                title: Text(contact.displayName ?? "eric"),
                subtitle: Text(
                  (contact.phones!.isNotEmpty
                      ? contact.phones!.elementAt(0).value ?? "00000000"
                      : "No phone number"),
                ),
                autofocus: true,
                leading: CircleAvatar(
                  child: Text(contact.initials()),
                ),
              );
            }),
      ),
    ));
  }
}
