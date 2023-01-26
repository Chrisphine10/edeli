import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final ValueChanged onFilter;

  FilterWidget({Key key, this.onFilter}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  Map<String, bool> delivery = {
    'Delivery': true,
    'Pickup': false,
  };
  Map<String, bool> openMarket = {
    'Opened': true,
    'Close': false,
  };
  Map<String, bool> fields = {
    'Grocery': true,
    'Restaurant': false,
    'Ice cream': false,
  };
  bool checkClick = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Filter',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  MaterialButton(
                      onPressed: () {},
                      child: Icon(Icons.delete_outline,
                          color: Theme.of(context).colorScheme.secondary))
                ],
              ),
            ),
            Expanded(
              child: ListView(
                primary: true,
                shrinkWrap: true,
                children: <Widget>[
                  ExpansionTile(
                    title: Text('Delivery pickup'),
                    children: delivery.keys.map((String key) {
                      return new CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: new Text(
                          key,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                        value: delivery[key],
                        onChanged: (bool value) {
                          setState(() {
                            delivery[key] = value;
                          });
                        },
                      );
                    }).toList(),
                    initiallyExpanded: true,
                  ),
                  ExpansionTile(
                    title: Text('Opened markets'),
                    children: openMarket.keys.map((String key) {
                      return new CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: new Text(
                          key,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                        value: openMarket[key],
                        onChanged: (bool value) {
                          setState(() {
                            openMarket[key] = value;
                          });
                        },
                      );
                    }).toList(),
                    initiallyExpanded: true,
                  ),
                  ExpansionTile(
                    title: Text('Fields'),
                    children: fields.keys.map((String key) {
                      return new CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: new Text(
                          key,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                        value: fields[key],
                        onChanged: (bool value) {
                          setState(() {
                            fields[key] = value;
                          });
                        },
                      );
                    }).toList(),
                    initiallyExpanded: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Apply filter',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}
