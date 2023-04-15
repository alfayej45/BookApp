
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void newPage(BuildContext context,Widget chil){
  Navigator.push(context, MaterialPageRoute(builder: (_)=>chil));
}
