import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Activity {
  final String name;
  final String pastTense;
  final int defaultValue;
  final String units;
  final int value;

  Activity({
    @required this.name,
    @required this.pastTense,
    @required this.defaultValue,
    @required this.units,
    @required this.value,
  });
}

List<Activity> activities = [
  Activity(name: "Run", pastTense: "Ran", defaultValue: 5, units: "km"),
  Activity(name: "Hike", pastTense: "Hiked", defaultValue: 3, units: "hr"),
];

class ActivityForm extends StatefulWidget {
  final Activity activity;

  ActivityForm({@required this.activity});

  @override
  _formState createState() {
    return _formState();
  }
}

class _formState extends State<ActivityForm> {
  final _formKey = GlobalKey<FormState>();

  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.activity.defaultValue.toString();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onSave() {
    print("Save");
    if (!_formKey.currentState.validate()) {
      return;
    }

    Activity a = Activity(
      value: int.parse(controller.text),
      name: widget.activity.name,
      defaultValue: widget.activity.defaultValue,
      units: widget.activity.units,
      pastTense: widget.activity.pastTense,
    );

    print("I ${a.pastTense} ${a.value} ${a.units}");

    Navigator.pop(context);
    Navigator.pop(context); // To dismiss the modal below, cheap and cheerful
  }

  void _onCancel() {
    print("Get me out of here");
    Navigator.pop(context);
    Navigator.pop(context); // To dismiss the modal below, cheap and cheerful
  }

  @override
  Widget build(BuildContext context) {
    // set up the AlertDialog
    String activeMsg = "I ${widget.activity.pastTense}";

    AlertDialog alert = AlertDialog(
      title: Text(activeMsg),
      content: Form(
          key: _formKey,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(0.0),
                            ),
                            borderSide: new BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: controller,
                        validator: (value) {
                          String errorMsg = "0 - 500";
                          int input;
                          try {
                            input = int.parse(value);
                          } catch (e) {
                            return errorMsg;
                          }

                          if (input < 0) {
                            return errorMsg;
                          }

                          if (input > 500) {
                            return errorMsg;
                          }

                          return null;
                        },
                      )),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(widget.activity.units.toUpperCase()),
                      ),
                    ]),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        child: Text("Cancel"),
                        onPressed: _onCancel,
                      ),
                      RaisedButton(
                        color: Colors.green,
                        child: Text("Save"),
                        onPressed: _onSave,
                      )
                    ],
                  ),
                ),
              ])),
    );

    return alert;
  }
}
