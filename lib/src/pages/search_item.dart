import 'package:flutter/material.dart';
import 'package:edeli/src/elements/AddCartSliderWidget.dart';
import 'package:edeli/src/elements/NoShopFoundWidget.dart';
import 'package:edeli/src/helpers/helper.dart';
import 'package:edeli/src/models/searchisresult.dart';


class SearchItem extends StatefulWidget {
  final List<ItemDetails> itemDetails;
  const SearchItem({Key key, this.itemDetails}) : super(key: key);

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {

  @override
  void initState() {


    // TODO: implement initState
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return widget.itemDetails.isNotEmpty?SingleChildScrollView(child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.itemDetails.length,
            scrollDirection: Axis.vertical,
            primary: false,
            itemBuilder: (context, index) {
              ItemDetails _itemData = widget.itemDetails.elementAt(index);

              return _itemData.shopId=='no_data'?NoShopFoundWidget():Column(
                  children:[
                    Container(
                        padding: EdgeInsets.only(left:20,right:20),
                        child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              CircleAvatar(
                                // ignore: deprecated_member_use
                                backgroundImage: NetworkImage(_itemData.logo),
                                maxRadius: 20,

                              ),

                              Expanded(
                                  child:Container(
                                      padding: EdgeInsets.only(left:10,),
                                      child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[
                                            Container(
                                                child:Text(_itemData.shopName,
                                                  style:Theme.of(context).textTheme.subtitle1,
                                                )
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(top:5,),
                                                child:Wrap(
                                                    children:[
                                                      Icon(Icons.access_time,size:15),
                                                      SizedBox(width:3),
                                                      Text(Helper.priceDistance(_itemData.distance),style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                                                          color:Theme.of(context).disabledColor.withOpacity(0.8)
                                                      ))),
                                                      SizedBox(width:6),
                                                      Icon(Icons.circle,color:Colors.green,size:15),
                                                      SizedBox(width:3),
                                                      Text(Helper.calculateTime(double.parse(_itemData.distance.replaceAll(',','')),0,false))
                                                    ]
                                                )
                                            )
                                          ]
                                      )
                                  )
                              ),
                              Align(
                                  child:Container(
                                      padding: EdgeInsets.only(left:10),
                                      child:IconButton(
                                          onPressed: (){
                                           // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  GroceryStoreWidget(shopDetails: _vendorData,shopTypeID: int.parse(_itemData.shopTypeID),focusId: int.parse(_itemData.focusId),)));
                                          },
                                          icon:Icon(Icons.arrow_forward_outlined)
                                      )
                                  )
                              )
                            ]
                        )
                    ),

                    SizedBox(height:5),


                    AddCartSliderWidget(productList: _itemData.productList, shopId: _itemData.shopId, shopName:_itemData.shopName ,subtitle: _itemData.subtitle,km: _itemData.distance,latitude: _itemData.latitude,longitude: _itemData.longitude,focusId: int.parse(_itemData.focusId),   ),
                  ]
              );

            }
        ),
      ],
    )):Container();
  }
}
