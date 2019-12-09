import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessContacts extends StatefulWidget {
  @override
  _AccessContactsState createState() => _AccessContactsState();
}

class _AccessContactsState extends State<AccessContacts> {
  Iterable<Contact> _contacts;

  @override
  void initState() {
    super.initState();
  }

  getContacts() async {
    PermissionStatus permissionStatus = await _getPermission();
    if (_contacts == null) {
      var contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts;
      });
    } else {
      throw PlatformException(
        code: 'PERMISSION_DENIED',
        message: 'Access to location data denied',
        details: null,
      );
    }
  }

  Future<PermissionStatus> _getPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
      await PermissionHandler()
          .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Access Contacts example')),
      body: Center(
        child: _contacts != null
            ? ListView.builder(
          itemCount: _contacts?.length ?? 0,
          itemBuilder: (context, index) {
            Contact c = _contacts?.elementAt(index);
            return ListTile(
              leading: (c.avatar != null && c.avatar.length > 0)
                  ? CircleAvatar(
                backgroundImage: MemoryImage(c.avatar),
              )
                  : CircleAvatar(child: Text(c.initials())),
              title: Text(c.displayName ?? ''),
            );
          },
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}