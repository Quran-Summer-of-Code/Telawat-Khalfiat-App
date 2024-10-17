import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(
        value: "ar.abdulbasitmurattal",
        child: Text("عبد الباسط عبد الصمد المرتل")),
    const DropdownMenuItem(
        value: "ar.abdullahbasfar", child: Text("عبد الله بصفر")),
    const DropdownMenuItem(
        value: "ar.husary", child: Text("محمود خليل الحصري")),
    const DropdownMenuItem(
        value: "ar.abdulsamad", child: Text("عبدالباسط عبدالصمد")),
    const DropdownMenuItem(value: "ar.hanirifai", child: Text("هاني الرفاعي")),
    const DropdownMenuItem(
        value: "ar.minshawi", child: Text("محمد صديق المنشاوي")),
    const DropdownMenuItem(
        value: "ar.mahermuaiqly", child: Text("ماهر المعيقلي")),
    const DropdownMenuItem(value: "ar.alafasy", child: Text("مشاري العفاسي")),
  ];
  return menuItems;
}
