import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MainApp(),
    ));

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cheap Shop Catalog Store'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: UserForm(),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Account user = Account();
  final datetext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);
    width = width - 30;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
          child: Column(children: <Widget>[
            SizedBox(height: 16),
            Text(
              'Purchaser Account',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: width / 2,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Name',
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid name';
                      }
                      user.name = value;
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: (width / 2),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Phone Number',
                      labelText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 8) {
                        return 'Please enter a valid Phone';
                      }
                      user.phone = value;
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your Postal Code',
                labelText: 'Postal Code',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid Postal Code';
                }
                user.postalcode = value;
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your Province',
                labelText: 'Province',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid province';
                }
                user.province = value;
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your City',
                labelText: "City",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the city you live in';
                }
                user.city = value;
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Delivery address',
                  labelText: 'Delivery Address'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the delivery address';
                }
                user.address = value;
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
                controller: datetext,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Today\'s Date',
                ),
                onTap: () async {
                  showDatePicker(
                          context: context,
                          initialDate:
                              user.date == null ? DateTime.now() : user.date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2090))
                      .then((date) {
                    if (date != null) {
                      user.date = date;
                      datetext.text =
                          '${user.date.month} / ${user.date.day} / ${user.date.year}';
                    }
                  });
                }),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: (width - width / 4) - 20,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Credit Card No.',
                        labelText: 'Credit Card Number'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length <= 16) {
                        return 'Please enter Correct Credit Card number';
                      }
                      user.cCNum = value;
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: width / 4,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'For dept use',
                        labelText: 'CCV'),
                    validator: (value) {
                      user.validationID = value;
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 9.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlueAccent,
                ),
                onPressed: () {
                  if (user.date == null) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ButtonBarTheme(
                            data: ButtonBarThemeData(
                                alignment: MainAxisAlignment.center),
                            child: AlertDialog(
                              title: Icon(Icons.cancel_outlined,
                                  color: Colors.redAccent, size: 35),
                              content: Text('Please Select a Date',
                                  textAlign: TextAlign.center),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('OK')),
                              ],
                            ),
                          );
                        });
                    return;
                  }
                  if (!(_formKey.currentState.validate())) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Welcome ${user.name}')));

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CatalogApp(
                            user: user,
                          )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(" CONTINUE ", style: TextStyle(fontSize: 26)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CatalogApp extends StatefulWidget {
  Account user;

  CatalogApp({this.user});

  @override
  _CatalogAppState createState() => _CatalogAppState();
}

class _CatalogAppState extends State<CatalogApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Catalog Items'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        elevation: 5,
      ),
      body: CatalogWidget(
        user: widget.user,
      ),
    );
  }
}

class CatalogWidget extends StatefulWidget {
  Account user;

  CatalogWidget({this.user});

  @override
  _CatalogWidgetState createState() => _CatalogWidgetState();
}

class _CatalogWidgetState extends State<CatalogWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Item item = new Item();
  List list = <Item>[];

  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 16),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Item Number',
                  labelText: 'Item Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter correct Item Number';
                }
                if (value.length < 6) {
                  for (int i = value.length; i < 6; i++) {
                    value += "   ";
                  }
                }
                item.itemNo = value;
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Cost of the Item',
                  labelText: 'Cost'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a correct Cost for the item';
                }
                item.cost = int.parse(value);
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Desired Quantity',
                  labelText: 'Quantity'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter correct Quantity';
                }
                item.quantity = int.parse(value);
                return null;
              },
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: Colors.lightBlueAccent),
                onPressed: () {
                  if (!(_formKey.currentState.validate())) return;

                  Item newItem = Item(
                      itemNo: item.itemNo,
                      quantity: item.quantity,
                      cost: item.cost);

                  setState(() {
                    total += newItem.cost * newItem.quantity;

                    list.add(newItem);

                    _formKey.currentState?.reset();
                  });
                },
                child: const Text(' Add Catalog Item ',
                    style: TextStyle(fontSize: 18)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.lightBlueAccent),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InvoiceApp(
                              user: widget.user,
                              list: list,
                              total: total,
                            )));
                  },
                  child: Text('   Trigger invoice   ',
                      style: TextStyle(fontSize: 18))),
            ),
            SizedBox(height: 10),
            Text(
              'Total: '
              '$total'
              ' \$',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 5),
            Divider(),
            SizedBox(height: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Item No.',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                Spacer(),
                Text('Item Cost', style: TextStyle(fontSize: 20)),
                Spacer(),
                Text('Quantity', style: TextStyle(fontSize: 20)),
                Spacer(),
                Text('     '),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: ListTile(
                          contentPadding: EdgeInsets.symmetric(),
                          title: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' ${list[index].itemNo}'),
                                Spacer(),
                                Text('${list[index].cost} \$ '),
                                Spacer(),
                                Text('${list[index].quantity}'),
                                Spacer()
                              ]),
                          trailing: Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                          ),
                          onTap: () {
                            setState(() {
                              total -= list[index].cost * list[index].quantity;
                              list.removeAt(index);
                            });
                          }),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceApp extends StatefulWidget {
  Account user;

  List<Item> list;

  int total;

  InvoiceApp({this.user, this.list, this.total});

  @override
  _InvoiceAppState createState() => _InvoiceAppState();
}

class _InvoiceAppState extends State<InvoiceApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        title: Text('INVOICE',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25)),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.check_circle_outline, color: Colors.green),
            onPressed: () => showDialog(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return ButtonBarTheme(
                  data: ButtonBarThemeData(alignment: MainAxisAlignment.center),
                  child: AlertDialog(
                    title: Icon(
                      Icons.priority_high_outlined,
                      color: Colors.red,
                      size: 30,
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Would you Like to confirm your purchase?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancel',
                            style: TextStyle(
                                fontSize: 17, color: Colors.red[500])),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                          child: Text('Confirm',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.green)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              // user must tap button!
                              builder: (BuildContext context) {
                                return ButtonBarTheme(
                                  data: ButtonBarThemeData(
                                      alignment: MainAxisAlignment.center),
                                  child: AlertDialog(
                                    title: Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Colors.green,
                                      size: 50,
                                    ),
                                    content: Text('Thank you for your purchase',
                                        textAlign: TextAlign.center),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainApp()),
                                                  (route) => false),
                                          child: Text('OK',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.lightGreen))),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                    ],
                  ),
                );
              },
            ),
          ),
        ],

        centerTitle: true,
        backgroundColor: Colors.white,
        // elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: InvoiceWidget(
            user: widget.user, list: widget.list, total: widget.total),
      ),
    );
  }
}

class InvoiceWidget extends StatefulWidget {
  Account user;

  List<Item> list;

  int total;

  InvoiceWidget({this.user, this.list, this.total});

  @override
  _InvoiceWidgetState createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends State<InvoiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 10, 5, 0),
          child: Row(children: [
            SizedBox(
              child: Text('BILLED TO',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(width: MediaQuery.of(context).size.width - 290),
            SizedBox(
              child: Text('DATE OF ISSUE :',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
          child: Row(children: [
            SizedBox(
              child: Text('${widget.user.name} , ${widget.user.phone} ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(width: MediaQuery.of(context).size.width - 369),
            SizedBox(
              child: Text(
                  '       ${widget.user.date.month} / ${widget.user.date.day} / ${widget.user.date.year}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
          child: Row(children: [
            SizedBox(
              child: Text('${widget.user.address} ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
          child: Row(children: [
            SizedBox(
              child: Text(
                  '${widget.user.postalcode} , ${widget.user.city} , ${widget.user.province} ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 10, 5, 0),
          child: Row(children: [
            SizedBox(
              child: Text('Credit Card Number:  ${widget.user.cCNum} ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ]),
        ),
        SizedBox(
          height: 15,
        ),
        Divider(),
        Row(
          children: [
            Expanded(
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Item No.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Cost',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Quantity',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  widget.list.length,
                  (int index) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text('${widget.list[index].itemNo}')),
                      DataCell(Text('${widget.list[index].cost} \$')),
                      DataCell(Text('${widget.list[index].quantity}'))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text('INVOICE TOTAL',
            style: TextStyle(fontSize: 40, color: Colors.grey)),
        SizedBox(height: 5),
        Text('${widget.total} \$', style: TextStyle(fontSize: 30)),
        SizedBox(height: 15)
      ],
    );
  }
}

class Account {
  var name;

  var phone;
  var postalcode;
  var province;
  var city;
  var address;
  DateTime date;
  var cCNum;
  var validationID;

  Account(
      {this.name,
      this.phone,
      this.postalcode,
      this.province,
      this.city,
      this.address,
      this.date,
      this.cCNum,
      this.validationID});
}

 class Item {
  var itemNo;
  int quantity;
  int cost;

  Item({this.itemNo, this.quantity, this.cost});
 }
