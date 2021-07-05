import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final pageViewController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Manager newsfeed',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      drawer: Drawer(
        elevation: 16,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: AutoSizeText(
                    'Validation',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: StreamBuilder<List<PostsRecord>>(
                stream: queryPostsRecord(),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<PostsRecord> listViewPostsRecordList = snapshot.data;
                  // Customize what your widget looks like with no query results.
                  if (snapshot.data.isEmpty) {
                    return Container(
                      height: 100,
                      child: Center(
                        child: Text('No results.'),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewPostsRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewPostsRecord =
                          listViewPostsRecordList[listViewIndex];
                      return StreamBuilder<PostsRecord>(
                        stream: PostsRecord.getDocument(
                            listViewPostsRecord.reference),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final cardPostsRecord = snapshot.data;
                          return Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF5F5F5),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 200,
                                  child: Builder(
                                    builder: (context) {
                                      final images =
                                          cardPostsRecord.images?.toList() ??
                                              [];
                                      return Container(
                                        width: double.infinity,
                                        height: 500,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 50),
                                              child: PageView.builder(
                                                controller: pageViewController,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: images.length,
                                                itemBuilder:
                                                    (context, imagesIndex) {
                                                  final imagesItem =
                                                      images[imagesIndex];
                                                  return Image.network(
                                                    'https://picsum.photos/seed/186/600',
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment(0, 1),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 10),
                                                child: SmoothPageIndicator(
                                                  controller:
                                                      pageViewController,
                                                  count: images.length,
                                                  axisDirection:
                                                      Axis.horizontal,
                                                  onDotClicked: (i) {
                                                    pageViewController
                                                        .animateToPage(
                                                      i,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease,
                                                    );
                                                  },
                                                  effect: ExpandingDotsEffect(
                                                    expansionFactor: 2,
                                                    spacing: 8,
                                                    radius: 16,
                                                    dotWidth: 16,
                                                    dotHeight: 16,
                                                    dotColor: Color(0xFF9E9E9E),
                                                    activeDotColor:
                                                        Color(0xFF3F51B5),
                                                    paintStyle:
                                                        PaintingStyle.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 25),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              listViewPostsRecord.name,
                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              listViewPostsRecord.urgency
                                                  .toString(),
                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: FlutterFlowTheme
                                                    .secondaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(-1, 0),
                                        child: Text(
                                          listViewPostsRecord.location,
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 8, 0, 0),
                                        child: Text(
                                          listViewPostsRecord.description,
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          final postsRecordData =
                                              createPostsRecordData(
                                            isValidated: false,
                                          );
                                          await cardPostsRecord.reference
                                              .update(postsRecordData);
                                        },
                                        text: 'Validate',
                                        options: FFButtonOptions(
                                          width: 130,
                                          height: 40,
                                          color: Color(0xFF3F9832),
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius: 12,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          final postsRecordData =
                                              createPostsRecordData(
                                            isValidated: false,
                                          );
                                          await listViewPostsRecord.reference
                                              .update(postsRecordData);
                                        },
                                        text: 'Reject',
                                        options: FFButtonOptions(
                                          width: 130,
                                          height: 40,
                                          color: Color(0xFFBB1F1F),
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
