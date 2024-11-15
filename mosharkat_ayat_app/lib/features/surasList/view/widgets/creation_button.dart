import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosharkat_ayat_app/app/route.dart';

class CreationButton extends StatefulWidget {
  //limit the number of ayahs to the number of ayahs in the sura
  final int numberOfAyahs;
  final int numberofsura;
  const CreationButton(
      {super.key, required this.numberOfAyahs, required this.numberofsura});

  @override
  State<CreationButton> createState() => _CreationButtonState();
}

class _CreationButtonState extends State<CreationButton> {
  int _formValue = 1;
  int _toValue = 1;
  final TextEditingController _tocontroller = TextEditingController();
  @override
  void dispose() {
    _tocontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 4, 129, 77), shape: BoxShape.circle),
      width: 200.w,
      height: 200.h,
      child: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(child: Text("تم مشاركة الآية")),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text("الي الآية رقم"),
                                SizedBox(
                                  width: 50.w,
                                  height: 150.h,
                                  child: TextField(
                                    keyboardType:
                                        TextInputType.number, // Only numbers
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter
                                          .digitsOnly, // Only digits
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                    controller: _tocontroller,
                                    onChanged: (value) {
                                      setState(() {
                                        _toValue = int.parse(value);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("من الآية رقم"),
                                SizedBox(
                                  width: 50.w,
                                  height: 150.h,
                                  child: TextField(
                                    keyboardType:
                                        TextInputType.number, // Only numbers
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter
                                          .digitsOnly, // Only digits
                                      LengthLimitingTextInputFormatter(
                                          3), // Limit to 3 digits
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _formValue = int.parse(value);
                                        _toValue = int.parse(value);
                                        _tocontroller.text = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            if (_formValue <= 0 ||
                                _formValue > widget.numberOfAyahs) {
                              _formValue = 1;
                            }
                            if (_toValue <= 0) {
                              _toValue = 1;
                            }
                            if (_toValue > widget.numberOfAyahs) {
                              _toValue = widget.numberOfAyahs;
                            }
                            if (_formValue > widget.numberOfAyahs) {
                              _formValue = 1;
                            }
                            if (_toValue < _formValue) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        textAlign: TextAlign.right,
                                        "نطاق غير صالح"),
                                    content: const Text(
                                        textAlign: TextAlign.right,
                                        "يجب أن تكون القيمة النهائية أكبر من أو تساوي القيمة الابتدائية."),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),
                                        child: const Text(
                                            style:
                                                TextStyle(color: Colors.white),
                                            "حسناً"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              Navigator.popAndPushNamed(
                                context,
                                RouteClass.editor,
                                arguments: {
                                  "numberOfSura": widget.numberofsura,
                                  "start": _formValue,
                                  "end": _toValue,
                                },
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            "تم",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  );
                });
          },
          icon: Icon(Icons.share, size: 75.sp, color: Colors.white)),
    );
  }
}
