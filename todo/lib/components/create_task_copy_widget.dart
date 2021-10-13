import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTaskCopyWidget extends StatefulWidget {
  CreateTaskCopyWidget({Key key}) : super(key: key);

  @override
  _CreateTaskCopyWidgetState createState() => _CreateTaskCopyWidgetState();
}

class _CreateTaskCopyWidgetState extends State<CreateTaskCopyWidget> {
  DateTime datePicked;
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 470,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.primaryBlack,
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              color: Color(0x5D000000),
              offset: Offset(0, -2),
            )
          ],
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Add Task',
                    style: FlutterFlowTheme.title2.override(
                      fontFamily: 'Lexend Deca',
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Fill out the details below to add a new task.',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: FlutterFlowTheme.tertiaryColor,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: TextFormField(
                controller: textController1,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Task Name',
                  labelStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                  ),
                  hintText: 'Enter your task here....',
                  hintStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.tertiaryColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.darkBG,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.darkBG,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: TextFormField(
                controller: textController2,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Details',
                  labelStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                  ),
                  hintText: 'Enter a description here...',
                  hintStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.tertiaryColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.darkBG,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.darkBG,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                ),
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: TextFormField(
                controller: textController3,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Due Date / Time',
                  labelStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                  ),
                  hintText: 'Enter your task here....',
                  hintStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.tertiaryColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.darkBG,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.darkBG,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: InkWell(
                onTap: () async {
                  await DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    onConfirm: (date) {
                      setState(() => datePicked = date);
                    },
                    currentTime: DateTime.now(),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.darkBG,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: FlutterFlowTheme.darkBG,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 14, 0, 0),
                    child: Text(
                      textController3.text,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      setState(() => _loadingButton1 = true);
                      try {
                        Navigator.pop(context);
                      } finally {
                        setState(() => _loadingButton1 = false);
                      }
                    },
                    text: 'Cancel',
                    options: FFButtonOptions(
                      width: 130,
                      height: 50,
                      color: FlutterFlowTheme.primaryBlack,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                    loading: _loadingButton1,
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      setState(() => _loadingButton2 = true);
                      try {
                        final toDoListCreateData = createToDoListRecordData(
                          toDoName: textController1.text,
                          toDoDescription: textController2.text,
                          toDoDate: datePicked,
                        );
                        await ToDoListRecord.collection
                            .doc()
                            .set(toDoListCreateData);
                        Navigator.pop(context);
                      } finally {
                        setState(() => _loadingButton2 = false);
                      }
                    },
                    text: 'Create Task',
                    options: FFButtonOptions(
                      width: 130,
                      height: 50,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                      ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 8,
                    ),
                    loading: _loadingButton2,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
