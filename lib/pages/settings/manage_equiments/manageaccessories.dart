import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:SolarExperto/models/accessories/accessoriesmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/constants.dart';
import '../../../global_widgets/Loading/loading.dart';
import '../../../global_widgets/nodata/noitems.dart';
import '../../../screen_widget/systemsettings/equipments/tiles/accessoriestiles.dart';
import '../../../screen_widget/systemsettings/equipments/add equiments/addaccessories.dart';
import '../../../services/database/database_service.dart';
import '../manage_equipments_details/manageaccesdetails.dart';

class ManageAccessories extends StatefulWidget {
  const ManageAccessories({Key? key}) : super(key: key);

  @override
  State<ManageAccessories> createState() => _ManageAccessoriesState();
}

class _ManageAccessoriesState extends State<ManageAccessories> {
  TextEditingController searched = TextEditingController();
  List<AccessoriesModel> _searchlist = [];
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
          .where('Categoryname', isEqualTo: 'Accessories')
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

              _searchlist.add(AccessoriesModel(
                  id: element.get('id') ?? '',
                  name: element.get('name') ?? '',
                  type: element.get('type') ?? '',
                  primary:
                      element.get('primary') ?? '',

                  secondary:
                      element.get('secondary') ?? '',
                  quantity: element.get('quantity') ?? '',
                  buyingprice: element.get('buyingprice') ?? '',
                  sellingprice: element.get('sellingprice') ?? '',
                  image: element.get('image') ?? '',
                  description: element.get('description') ?? '',
                  Categoryname: element.get('Categoryname') ?? '',
                  addedday: element.get('addedday')));

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
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.bgColor,
          elevation: 0,
          title: Text(
            'Accessories',
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
                      return AddAccessories();
                      // AddAppliances()
                    });
              },
              icon: Icon(
                Icons.add,
                color: AppColor.bgSideMenu,
              ),
              label: Text(''),
            ),
          ],
        ),
        body: Container(
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
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search Accessories',
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
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
                                        maxCrossAxisExtent: (!AppResponsive
                                                .isMobile(context))
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2
                                            : 390,
                                        childAspectRatio: (!AppResponsive
                                                .isMobile(context))
                                            ? 3 / 2
                                            : 3 / 2,
                                        crossAxisSpacing:
                                            (!AppResponsive.isMobile(context))
                                                ? 10
                                                : 0,
                                        mainAxisSpacing:
                                            (!AppResponsive.isMobile(context))
                                                ? 5
                                                : 5),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ManageAccessDetails(
                                                      accessoriesModel:
                                                          _searchlist[index]!,
                                                    )));
                                      },
                                      child: AccessoriesTiles(
                                        accessoryModel: _searchlist[index]!,
                                      ));
                                }),
                          )
                        : const NoData()
                    : StreamBuilder<List<AccessoriesModel?>?>(
                        stream: DatabaseService().accessories,
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
                                                        ManageAccessDetails(
                                                          accessoriesModel:
                                                              snapshot.data![
                                                                  index]!,
                                                        )));
                                          },
                                          child: AccessoriesTiles(
                                            accessoryModel:
                                                snapshot.data![index]!,
                                          ));
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
    );
  }
}
