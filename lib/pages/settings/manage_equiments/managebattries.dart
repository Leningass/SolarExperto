import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../constants/constants.dart';
import '../../../global_widgets/Loading/loading.dart';
import '../../../global_widgets/nodata/noitems.dart';
import '../../../models/equipments/batteriesmodel.dart';
import '../../../screen_widget/systemsettings/equipments/add equiments/addbattery.dart';
import '../../../screen_widget/systemsettings/equipments/tiles/batteriestiles.dart';
import '../../../services/database/database_service.dart';
import '../manage_equipments_details/managebatterydetails.dart';

class ManageBattries extends StatefulWidget {
  const ManageBattries({Key? key}) : super(key: key);

  @override
  State<ManageBattries> createState() => _ManageBattriesState();
}

class _ManageBattriesState extends State<ManageBattries> {
  TextEditingController searched = TextEditingController();
  List<BatteriesModel> _searchlist = [];
  String name = '';
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
          .collection(equipmentCollection)
          .where('Categoryname', isEqualTo: 'Battery')
          .orderBy('name')
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

              _searchlist.add(BatteriesModel(
                id: element.get('id') ?? '',
                name: element.get('name') ?? '',
                type: element.get('type') ?? '',
                voltage: element.get('voltage') ?? 0,
                capacity: element.get('capacity') ?? 0,
                deep_of_discharge: element.get('deep_of_discharge') ?? 0,
                quantity: element.get('quantity') ?? 0,
                buyingprice: element.get('buyingprice') ?? 0,
                sellingprice: element.get('sellingprice') ?? 0,
                image: element.get('image') ?? '',
                description: element.get('description') ?? '',
                Categoryname: element.get('Categoryname') ?? '',
                addedday: element.get('addedday') ?? '',
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
  final List<int> _selectedItems =<int>[];
  List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  List<bool> _isChecked = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.bgColor,
          elevation: 0,
          title: const Text(
            'Batteries',
          ),
          actions: [
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: AppColor.bgColor,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) {
                      return AddBattery();
                      // AddAppliances()
                    });
              },
              icon: Icon(
                Icons.add,
                color: AppColor.bgSideMenu,
              ),
              label: const Text(''),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.yellow.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          controller: searched,
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search Battries',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (name != '')
                          ? (_searchlist.isNotEmpty)
                              ? SingleChildScrollView(
                                  child: GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: _searchlist.length,
                                      shrinkWrap: true,
                                      physics: PageScrollPhysics(),
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
                                                      : 3 / 2,
                                              crossAxisSpacing:
                                                  (!AppResponsive.isMobile(
                                                          context))
                                                      ? 10
                                                      : 0,
                                              mainAxisSpacing:
                                                  (!AppResponsive.isMobile(
                                                          context))
                                                      ? 5
                                                      : 5),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ManageBatteryDetails(
                                                            batteryModel:
                                                                _searchlist![
                                                                    index],
                                                          )));
                                            },
                                            child: BatteriesTiles(
                                              batteriesModel:
                                                  _searchlist[index],
                                            ));
                                      }),
                                )
                              : const NoData()
                          : StreamBuilder<List<BatteriesModel?>?>(
                              stream: DatabaseService().batteries,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.length == 0) {
                                    return Center(
                                      child: NoData(),
                                    );
                                  } else {
                                    return SingleChildScrollView(
                                      child: GridView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: snapshot.data!.length,
                                          shrinkWrap: true,
                                          physics: PageScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent:
                                                      (!AppResponsive.isMobile(
                                                              context))
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2
                                                          : 390,
                                                  childAspectRatio:
                                                      (!AppResponsive.isMobile(
                                                              context))
                                                          ? 3 / 2
                                                          : 3 / 2,
                                                  crossAxisSpacing:
                                                      (!AppResponsive.isMobile(
                                                              context))
                                                          ? 10
                                                          : 0,
                                                  mainAxisSpacing:
                                                      (!AppResponsive.isMobile(
                                                              context))
                                                          ? 5
                                                          : 5),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ManageBatteryDetails(
                                                              batteryModel:
                                                                  snapshot.data![
                                                                      index]!,
                                                            )));
                                              },
                                              child: BatteriesTiles(
                                                batteriesModel:
                                                    snapshot.data![index]!,
                                              ),
                                            );
                                          }),
                                    );
                                  }
                                } else {
                                  return const Center(
                                    child: Loading(),
                                  );
                                }
                              },
                            )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
