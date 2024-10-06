import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/global_widgets/customtext/customtext.dart';
import 'package:SolarExperto/global_widgets/decoration/tab_decoration.dart';
import 'package:SolarExperto/global_widgets/header/header_widget.dart';
import 'package:SolarExperto/pages/finance/financedetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../global_widgets/Loading/loading.dart';
import '../../global_widgets/nodata/noitems.dart';
import '../../models/finance/financemodel.dart';
import '../../services/database/database_service.dart';
import 'addsale.dart';
import 'financetile.dart';

class Finance extends StatefulWidget {
  const Finance({Key? key}) : super(key: key);

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> with TickerProviderStateMixin {
  TextEditingController searched = TextEditingController();
  List<FinanceModel> _searchlist = [];
  String name = '';
  late FinanceDataSource financeDataSource;

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
          .collection(financeCollection)
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

              _searchlist.add(FinanceModel(
                id: element.get('id') ?? '',
                name: element.get('name'),
                date: element.get('date') ?? '',
                payment: element.get('payment') ?? '',
              ));

              // result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
            });
            //result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
            _searchlist.toSet().toList();
            print('Search List: ${_searchlist.length}');
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// Header Part
            HeaderWidget(Routname: "Sale"),
            SizedBox(
              height: appPadding,
            ),
            SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sales',
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
                                        return AddSale();
                                      });
                                },
                                child: Center(
                                  child: Text(
                                    'Add Sales',
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
                                hintText: 'Search Sale',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (name != '')
                              ? (_searchlist.isNotEmpty)
                                  ? ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _searchlist.length,
                                      itemBuilder: (context, index) {
                                        financeDataSource =
                                            FinanceDataSource(_searchlist);
                                        return SfDataGrid(
                                          columnWidthMode: ColumnWidthMode.fill,
                                          headerGridLinesVisibility: GridLinesVisibility.both,
                                         // allowSorting: true,
                                          gridLinesVisibility: GridLinesVisibility.both,

                                          source: financeDataSource,
                                          columns: <GridColumn>[
                                            GridColumn(
                                                columnName: 'id',
                                                label: Container(
                                                    padding:
                                                    EdgeInsets.all(
                                                        16.0),
                                                    alignment:
                                                    Alignment.center,
                                                    child: Text(
                                                      'ID',
                                                    ))),
                                            GridColumn(
                                                columnName: 'name',
                                                label: Container(
                                                    padding:
                                                    EdgeInsets.all(
                                                        8.0),
                                                    alignment:
                                                    Alignment.center,
                                                    child: Text('Name'))),
                                            GridColumn(
                                                columnName: 'date',
                                                label: Container(
                                                    padding:
                                                    EdgeInsets.all(
                                                        8.0),
                                                    alignment:
                                                    Alignment.center,
                                                    child: Text(
                                                      'Date',
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                    ))),
                                            GridColumn(
                                                columnName: 'payment',
                                                label: GestureDetector(
                                                  child: Container(
                                                      padding:
                                                      EdgeInsets.all(
                                                          8.0),
                                                      alignment:
                                                      Alignment.center,
                                                      child:
                                                      Text('Payment')),
                                                )),
                                          ],
                                        );
                                      })
                                  : const yelloNoData()
                              : StreamBuilder<List<FinanceModel?>?>(
                                  stream: DatabaseService().finances,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.length == 0) {
                                        return Center(
                                          child: yelloNoData(),
                                        );
                                      } else {
                                        financeDataSource =
                                            FinanceDataSource(snapshot.data);
                                        return SfDataGrid(
                                          columnWidthMode: ColumnWidthMode.fill,
                                         headerGridLinesVisibility: GridLinesVisibility.both,
                                        //  allowSorting: true,
                                          gridLinesVisibility: GridLinesVisibility.both,

                                          source: financeDataSource,
                                          columns: <GridColumn>[
                                            GridColumn(
                                                columnName: 'id',
                                                label: Container(
                                                    padding:
                                                        EdgeInsets.all(
                                                            16.0),
                                                    alignment:
                                                        Alignment.center,
                                                    child: Text(
                                                      'ID',
                                                    ))),
                                            GridColumn(
                                                columnName: 'name',
                                                label: Container(
                                                    padding:
                                                        EdgeInsets.all(
                                                            8.0),
                                                    alignment:
                                                        Alignment.center,
                                                    child: Text('Name'))),
                                            GridColumn(
                                                columnName: 'date',
                                                label: Container(
                                                    padding:
                                                        EdgeInsets.all(
                                                            8.0),
                                                    alignment:
                                                        Alignment.center,
                                                    child: Text(
                                                      'Date',
                                                      overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                    ))),
                                            GridColumn(
                                                columnName: 'payment',
                                                label: Container(
                                                    padding:
                                                        EdgeInsets.all(
                                                            8.0),
                                                    alignment:
                                                        Alignment.center,
                                                    child:
                                                        Text('Payment'))),
                                          ],
                                        );
                                      }
                                    } else {
                                      return const Center(
                                        child: Loading(),
                                      );
                                    }
                                  })
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
