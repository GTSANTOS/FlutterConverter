import 'dart:ui'; 
import 'package:flutter/material.dart'; 

class Conversao extends StatefulWidget {
  @override
  _ConversaoState createState() => _ConversaoState(); 
}

class _ConversaoState extends State < Conversao >  {
  final TextEditingController _reaisController = TextEditingController(); 
  final TextEditingController _dolarController = TextEditingController(); 
  final key = GlobalKey < ScaffoldState > (); 
  var _dolar = ''; 

  _limpar() {
    _reaisController.clear(); 
    _dolarController.clear(); 
    setState(() {
      _dolar = ''; 
    }); 
  }

  _calcular() {
    if (_reaisController.text.isEmpty || _dolarController.text.isEmpty) {
      setState(() {
        _dolar = ''; 
      }); 
      key.currentState.showSnackBar(SnackBar(
        content:Text('Valor em real e a cotaçaõ do dólar são obrigatórios.'), )); 
    }else {
      try {
        var real = double.parse(_reaisController.text); 
        var cotacao = double.parse(_dolarController.text); 
        setState(() {
          _dolar = 'Total em dólares: ' + (real * cotacao).toStringAsFixed(2); 
        }); 
      }catch (e) {
        key.currentState.showSnackBar(SnackBar(
          content:Text(
              'Valor em real ou cotaçaõ do dólar informados em formato inválido'), )); 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:key, 
      appBar:AppBar(
          title:Center(
        child:Text('Reais para Dólar'), )), 
      body:Column(
        mainAxisAlignment:MainAxisAlignment.spaceEvenly, 
        children:[
          Image.asset("assets/conversao.png", width:200), 
          TextField(
            controller:_reaisController, 
            keyboardType:TextInputType.numberWithOptions(decimal:true), 
            decoration:InputDecoration(
                icon:Icon(Icons.monetization_on), 
                hintText:'Valor em Reais', 
                border:OutlineInputBorder(
                  borderRadius:BorderRadius.circular(20), )), ), 
          TextField(
            controller:_dolarController, 
            keyboardType:TextInputType.numberWithOptions(decimal:true), 
            decoration:InputDecoration(
                icon:Icon(Icons.attach_money), 
                hintText:'Cotação do Dólar', 
                border:OutlineInputBorder(
                    borderRadius:BorderRadius.circular(20))), ), 
          Text(
            _dolar, 
            style:TextStyle(fontSize:20), ), 
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly, 
            children:[
              FlatButton(
                  color:Colors.blue, 
                  textColor:Colors.white, 
                  disabledColor:Colors.grey, 
                  disabledTextColor:Colors.black, 
                  padding:EdgeInsets.all(8.0), 
                  splashColor:Colors.blueAccent, 
                  onPressed:_limpar, 
                  child:Text("Limpar")), 
              FlatButton(
                  onPressed:_calcular, 
                  color:Colors.blue, 
                  textColor:Colors.white, 
                  disabledColor:Colors.grey, 
                  disabledTextColor:Colors.black, 
                  padding:EdgeInsets.all(8.0), 
                  splashColor:Colors.blueAccent, 
                  child:Text("Converter"))
            ], )
        ], ), ); 
  }
}
