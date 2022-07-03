import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';

import 'VideoWidget.dart';

class VideoList extends StatelessWidget {
  Object? newData;
  VideoList(this.newData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = json.decode(newData.toString());
    var _size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          InViewNotifierList(
            scrollDirection: Axis.vertical,
            initialInViewIds: ['0'],
            isInViewPortCondition: (double deltaTop, double deltaBottom,
                double viewPortDimension) {
              return deltaTop < (0.5 * viewPortDimension) &&
                  deltaBottom > (0.5 * viewPortDimension);
            },
            itemCount: data == null ? 0 : data.length,
            builder: (BuildContext context, int index) {
              return Container(
                width: double.infinity,
                height: _size.height / 2.5,
                alignment: Alignment.center,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return InViewNotifierWidget(
                      id: '$index',
                      builder:
                          (BuildContext context, bool isInView, Widget? child) {
                        return isInView
                            ? Container(
                                width: _size.width,
                                height: _size.height / 3.1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: VideoWidget(
                                            play: isInView,
                                            url: data[index]['videoUrl']),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 20),
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
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: _size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: _size.height / 3.1,
                                    child: Image.network(
                                      data[index]['coverPicture'],
                                      fit: BoxFit.fill,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const Center(
                                          child: SpinKitFadingCircle(
                                            color: Colors.amber,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
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
      ),
    );
  }
}
