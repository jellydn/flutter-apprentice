import '../backend/backend.dart';
import '../create_task_page/create_task_page_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../task_details/task_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTasksWidget extends StatefulWidget {
  MyTasksWidget({Key key}) : super(key: key);

  @override
  _MyTasksWidgetState createState() => _MyTasksWidgetState();
}

class _MyTasksWidgetState extends State<MyTasksWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'My Tasks',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Lexend Deca',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.darkBG,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: FlutterFlowTheme.primaryColor,
        elevation: 8,
        child: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          buttonSize: 48,
          icon: Icon(
            Icons.add_rounded,
            color: FlutterFlowTheme.white,
            size: 30,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                duration: Duration(milliseconds: 270),
                reverseDuration: Duration(milliseconds: 270),
                child: CreateTaskPageWidget(),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 53,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.darkBG,
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: Image.asset(
                        'assets/images/waves@2x.png',
                      ).image,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Scheduled Tasks',
                    style: FlutterFlowTheme.bodyText2.override(
                      fontFamily: 'Lexend Deca',
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: StreamBuilder<List<ToDoListRecord>>(
                        stream: queryToDoListRecord(
                          queryBuilder: (toDoListRecord) =>
                              toDoListRecord.orderBy('toDoDate'),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  color: FlutterFlowTheme.primaryColor,
                                ),
                              ),
                            );
                          }
                          List<ToDoListRecord> columnToDoListRecordList =
                              snapshot.data;
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  List.generate(columnToDoListRecordList.length,
                                      (columnIndex) {
                                final columnToDoListRecord =
                                    columnToDoListRecordList[columnIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 8),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TaskDetailsWidget(
                                            toDoNote:
                                                columnToDoListRecord.reference,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.primaryBlack,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      columnToDoListRecord
                                                          .toDoName,
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 4, 0, 0),
                                                      child: Text(
                                                        dateTimeFormat(
                                                            'MMMEd',
                                                            columnToDoListRecord
                                                                .toDoDate),
                                                        style: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color:
                                                              FlutterFlowTheme
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 12, 0),
                                                  child: ToggleIcon(
                                                    onPressed: () async {
                                                      final toDoListUpdateData =
                                                          createToDoListRecordData(
                                                        toDoState:
                                                            !columnToDoListRecord
                                                                .toDoState,
                                                      );
                                                      await columnToDoListRecord
                                                          .reference
                                                          .update(
                                                              toDoListUpdateData);
                                                    },
                                                    value: columnToDoListRecord
                                                        .toDoState,
                                                    onIcon: Icon(
                                                      Icons.check_circle,
                                                      color: FlutterFlowTheme
                                                          .primaryColor,
                                                      size: 25,
                                                    ),
                                                    offIcon: Icon(
                                                      Icons.radio_button_off,
                                                      color: Color(0xFF2B343A),
                                                      size: 25,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
