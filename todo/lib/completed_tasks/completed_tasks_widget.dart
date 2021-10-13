import '../backend/backend.dart';
import '../components/create_task_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedTasksWidget extends StatefulWidget {
  CompletedTasksWidget({Key key}) : super(key: key);

  @override
  _CompletedTasksWidgetState createState() => _CompletedTasksWidgetState();
}

class _CompletedTasksWidgetState extends State<CompletedTasksWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Completed Tasks',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Lexend Deca',
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.darkBG,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Container(
                height: 410,
                child: CreateTaskWidget(),
              );
            },
          );
        },
        backgroundColor: FlutterFlowTheme.primaryColor,
        elevation: 8,
        child: Icon(
          Icons.add_rounded,
          color: FlutterFlowTheme.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/images/waves@2x.png',
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  fit: BoxFit.cover,
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                        child: StreamBuilder<List<ToDoListRecord>>(
                          stream: queryToDoListRecord(
                            queryBuilder: (toDoListRecord) => toDoListRecord
                                .where('toDoState', isEqualTo: true)
                                .orderBy('toDoDate'),
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
                            if (columnToDoListRecordList.isEmpty) {
                              return Center(
                                child: Image.asset(
                                  'assets/images/uiList_Empty@3x.png',
                                ),
                              );
                            }
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    columnToDoListRecordList.length,
                                    (columnIndex) {
                                  final columnToDoListRecord =
                                      columnToDoListRecordList[columnIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 8),
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
                                  );
                                }),
                              ),
                            );
                          },
                        ),
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
