import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../constants/constants.dart';
import '../../../global_widgets/Loading/loading.dart';
import '../../../global_widgets/nodata/noitems.dart';

import '../../../models/equipments/controllermodel.dart';

import '../../../screen_widget/systemsettings/equipments/add equiments/addchargecontroler.dart';
import '../../../screen_widget/systemsettings/equipments/tiles/ControllerTiles.dart';
import '../../../services/database/database_service.dart';
import '../manage_equipments_details/managechargedetails.dart';

class ManageChargeControler extends StatefulWidget {
  const ManageChargeControler({Key? key}) : super(key: key);

  @override
  State<ManageChargeControler> createState() => _ManageChargeControlerState();
}

class _ManageChargeControlerState extends State<ManageChargeControler> {
  TextEditingController searched = TextEditingController();
  List<ChargeControllerModel> _searchlist = [];
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
          .where('Categoryname', isEqualTo: 'Controler')
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

              _searchlist.add(ChargeControllerModel(
                id: element.get('id') ?? '',
                name: element.get('name') ?? '',
                type: element.get('type') ?? '',
                ratedVoltage: element.get('ratedVoltage') ?? 0,
                current: element.get('current') ?? 0,
                buyingprice: element.get('buyingprice') ?? 0,
                sellingprice: element.get('sellingprice') ?? 0,
                image: element.get('image') ?? '',
                description: element.get('description') ?? '',
                Categoryname: element.get('Categoryname') ?? '',
                addedday: element.get('addedday') ?? '',
                quantity: element.get('quantity') ?? 0,
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
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.bgColor,
          elevation: 0,
          title: Text(
            'Charge Controller',
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
                      return AddChargeController();
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
                const SizedBox(
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
                      hintText: 'Search Controller',
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
                                                    ManageChargeDetails(
                                                      chargeControllerModel:
                                                          _searchlist[index]!,
                                                    )));
                                      },
                                      child: ControllerTiles(
                                        controllerModel: _searchlist[index]!,
                                      ));
                                }),
                          )
                        : const NoData()
                    : StreamBuilder<List<ChargeControllerModel?>?>(
                        stream: DatabaseService().controllers,
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
                                                        ManageChargeDetails(
                                                          chargeControllerModel:
                                                              snapshot.data![
                                                                  index]!,
                                                        )));
                                          },
                                          child: ControllerTiles(
                                            controllerModel:
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
