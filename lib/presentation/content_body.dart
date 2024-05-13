import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:test_app/presentation/side_bar.dart';
import '../data/model/post_response.dart';

class ContentBody extends StatefulWidget {
  final PostResponse? selectedValue;
   const ContentBody({super.key, required this.selectedValue});


  @override
  State<ContentBody> createState() => _ContentBodyState();
}

class _ContentBodyState extends State<ContentBody> {


  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: widget. selectedValue != null
                ? Text(
                   widget. selectedValue!.title,
                    style: const TextStyle(color: Colors.white, fontSize: 18.0),
                  )
                : const Text('No value selected'),
          ),
        ),
        SideBar(controller: _controller),
      ],
    );
  }
}
