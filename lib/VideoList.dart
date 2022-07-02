import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';

import 'VideoWidget.dart';

class VideoList extends StatelessWidget {
  Object? newData;
  VideoList(this.newData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = json.decode(newData.toString());
    var _size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        InViewNotifierList(
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.5 * viewPortDimension) &&
                deltaBottom > (0.5 * viewPortDimension);
          },
          itemCount: data == null ? 0 : data.length,
          builder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: _size.height / 2.5,
              margin: EdgeInsets.only(top: 60),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return InViewNotifierWidget(
                    id: '$index',
                    builder:
                        (BuildContext context, bool isInView, Widget? child) {
                      return isInView
                          ? Container(
                              width: _size.width,
                              height: _size.height / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black26,
                              ),
                              child: VideoWidget(
                                  play: isInView, url: data[index]['videoUrl']),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: _size.width,
                                  height: _size.height / 3,
                                  child: Image.network(
                                    data[index]['coverPicture'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    data[index]['id'].toString() +
                                        " | " +
                                        data[index]['title'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )
                              ],
                            );
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
