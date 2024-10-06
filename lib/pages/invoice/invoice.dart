import 'dart:io';
import 'dart:ui';
import 'package:SolarExperto/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../global_widgets/Loading/loading.dart';
import '../../../../global_widgets/header/header_widget.dart';
import '../../../../global_widgets/nodata/noitems.dart';
import '../../../../models/customers/customermodel.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/UplaodImages.dart';
import '../../../../utilis/date.dart';
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';

import 'package:pdf/widgets.dart' as pw;

import '../../models/invoices/invoicemodel.dart';
import 'invoicetile.dart';
class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  TextEditingController searched = TextEditingController();
 // List<InvoiceModel> _searchlist = [];
  String name = '';
  @override
  void initState() {
   // _searchlist.clear();

   // searched.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
  //  searched.removeListener(_onSearchChanged);
  //  searched.dispose();
  //  _searchlist.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

   // _searchlist.clear();
  }

  void _onSearchChanged() {
   // searchResultsList();
  }

  /*searchResultsList() {
    _searchlist.clear();
    if (searched.text != "") {
      FirebaseFirestore.instance
          .collection(invoicecollection)
          .orderBy(
            "name",
          )
          .get()
          .then((value) {
        _searchlist = [];
        value.docs.forEach((element) {
          if (element
              .get('name')
              .toLowerCase()
              .contains(searched.text.toLowerCase())) {
            setState(() {
              print('${element.get('name')}');

   // _searchlist.add(InvoiceModel(
   //              id: element.get('id') ?? '',
   //              name: element.get('name') ?? '',
   //              date: element.get('date') ?? '',
   //
   //              payment: element.get('payment') ?? '',
   //            ));

              // result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
            });
            //result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
           // _searchlist.toList();
           // print('Search List: ${_searchlist.length}');
          }
        });
      });
    }
  }*/


  @override
  Widget build(BuildContext context) {

      return Column(
        children: [
          /// Header Part
          const HeaderWidget(Routname: "Invoices"),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [

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
                                hintText: 'Search Invoices',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // (name != '')
                          //     ? (_searchlist.isNotEmpty)
                          //     ? GridView.builder(
                          //     scrollDirection: Axis.vertical,
                          //     itemCount: _searchlist.length,
                          //     physics: PageScrollPhysics(),
                          //     shrinkWrap: true,
                          //     gridDelegate:
                          //     SliverGridDelegateWithMaxCrossAxisExtent(
                          //         maxCrossAxisExtent:
                          //         (!AppResponsive.isMobile(
                          //             context))
                          //             ? MediaQuery.of(context)
                          //             .size
                          //             .width /
                          //             2
                          //             : 390,
                          //         childAspectRatio:
                          //         (!AppResponsive.isMobile(
                          //             context))
                          //             ? 3 / 2
                          //             : 2,
                          //         crossAxisSpacing:
                          //         (!AppResponsive.isMobile(
                          //             context))
                          //             ? 10
                          //             : 0,
                          //         mainAxisSpacing:
                          //         (!AppResponsive.isMobile(
                          //             context))
                          //             ? 5
                          //             : 20),
                          //     itemBuilder: (context, index) {
                          //       return InvoiceTile(
                          //         invoiceModel: _searchlist[index],
                          //       );
                          //     })
                          //     : const yelloNoData()
                          //     :
                          StreamBuilder<List<InvoiceModel?>?>(
                            stream: DatabaseService().invoices,
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
                                        return InvoiceTile(
                                          invoiceModel:
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

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  }
}
