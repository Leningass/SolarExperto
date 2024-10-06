import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/global_widgets/header/header_widget.dart';
import 'package:SolarExperto/pages/customers/customerdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_responsive.dart';
import '../../global_widgets/Loading/loading.dart';
import '../../global_widgets/nodata/noitems.dart';
import '../../models/customers/customermodel.dart';
import '../../screen_widget/systemsettings/customerdata/addcustomers.dart';
import '../../services/database/database_service.dart';
import 'customertile.dart';

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  String customername = '';
  TextEditingController searched = TextEditingController();
  List<CustomerModel> _searchlist = [];

  @override
  void initState() {
    _searchlist.clear();

    searched.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    searched.removeListener(_onSearchChanged);
    searched.dispose();
    _searchlist.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _searchlist.clear();
  }

  void _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    _searchlist.clear();
    if (searched.text != "") {
      FirebaseFirestore.instance
          .collection(customerCollection)
          .orderBy("customername")
          .get()
          .then((value) {
        _searchlist = [];
        value.docs.forEach((element) {
          if (element
              .get('customername')
              .toLowerCase()
              .contains(searched.text.toLowerCase())) {
            setState(() {
              print('${element.get('customername')}');

              _searchlist.add(CustomerModel(
                  id: element.get("customerid"),
                  name: element.get("customername"),
                  phone: element.get("customerphon"),
                  email: element.get("customeremail"),
                  address: element.get("customeraddress"),
                  addedday: element.get("addedday")));

              // result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
            });
            //result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
            _searchlist.toList();
            print('Search List: ${_searchlist.length}');
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            /// Header Part
            const HeaderWidget(Routname: "Customers"),
            SingleChildScrollView(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Customers',
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              ElevatedButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: AppColor.bgSideMenu,
                                    padding: EdgeInsets.all(20.0),
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (dialogContext) {
                                        return const AddCustomers();
                                      });
                                },
                                child: Center(
                                  child: Text(
                                    'Add Customer',
                                    style: TextStyle(
                                      color: AppColor.bgColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: TextField(
                              controller: searched,
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search Customers',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  customername = value;
                                  _searchlist.clear();
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          (customername != '')
                              ? (_searchlist.isNotEmpty)
                                  ? GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: _searchlist.length,
                                      physics: PageScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent:
                                                  (!AppResponsive.isMobile(
                                                          context))
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2
                                                      : 390,
                                              childAspectRatio:
                                                  (!AppResponsive.isMobile(
                                                          context))
                                                      ? 3 / 2
                                                      : 2,
                                              crossAxisSpacing:
                                                  (!AppResponsive.isMobile(
                                                          context))
                                                      ? 10
                                                      : 0,
                                              mainAxisSpacing:
                                                  (!AppResponsive.isMobile(
                                                          context))
                                                      ? 5
                                                      : 20),
                                      itemBuilder: (context, index) {
                                        return CustomerTiles(
                                          customerModel: _searchlist[index]!,
                                        );
                                      })
                                  : const yelloNoData()
                              : StreamBuilder<List<CustomerModel?>?>(
                                  stream: DatabaseService().customers,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.length == 0) {
                                        return Center(
                                          child: yelloNoData(),
                                        );
                                      } else {
                                        return GridView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot.data!.length,
                                            shrinkWrap: true,
                                            //physics: PageScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent:
                                                        (!AppResponsive
                                                                .isMobile(
                                                                    context))
                                                            ? MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2
                                                            : 390,
                                                    childAspectRatio:
                                                        (!AppResponsive
                                                                .isMobile(
                                                                    context))
                                                            ? 3 / 2
                                                            : 2,
                                                    crossAxisSpacing:
                                                        (!AppResponsive
                                                                .isMobile(
                                                                    context))
                                                            ? 10
                                                            : 0,
                                                    mainAxisSpacing:
                                                        (!AppResponsive
                                                                .isMobile(
                                                                    context))
                                                            ? 5
                                                            : 20),
                                            itemBuilder: (context, index) {
                                              return CustomerTiles(
                                                customerModel:
                                                    snapshot.data![index]!,
                                              );
                                            });
                                      }
                                    } else {
                                      return const Center(
                                        child: Loading(),
                                      );
                                    }
                                  },
                                ),

                          // Expanded(
                          //   child: Container(
                          //     height: MediaQuery.of(context).size.height,
                          //     padding: EdgeInsets.all(appPadding),
                          //     decoration: BoxDecoration(
                          //       color: AppColor.white,
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Column(
                          //      crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //
                          //         SizedBox(
                          //           height: 10.0,
                          //         ),
                          //        /* Expanded(
                          //           child: SingleChildScrollView(
                          //             child: Row(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 Expanded(
                          //                   child: Container(
                          //                     child: Column(
                          //                       children: [
                          //                         //Discussions(),
                          //                         SizedBox(
                          //                           height: 20,
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 *//*Expanded(
                          //                   child: Container(
                          //                     margin: EdgeInsets.symmetric(
                          //                         horizontal: 10),
                          //                     child: Column(
                          //                       children: [
                          //                         CalendarWidget(),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),*//*
                          //               ],
                          //             ),
                          //           ),
                          //         )*/
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
