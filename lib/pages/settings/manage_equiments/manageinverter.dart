import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../constants/constants.dart';
import '../../../global_widgets/Loading/loading.dart';
import '../../../global_widgets/nodata/noitems.dart';
import '../../../models/equipments/inverter_model.dart';
import '../../../screen_widget/systemsettings/equipments/add equiments/addinverter,dart.dart';
import '../../../screen_widget/systemsettings/equipments/tiles/InverterTiles.dart';
import '../../../services/database/database_service.dart';
import '../manage_equipments_details/manageinverterdetails.dart';

class ManageInverter extends StatefulWidget {
  const ManageInverter({Key? key, this.inverterModel}) : super(key: key);
  final InverterModel? inverterModel;

  @override
  State<ManageInverter> createState() => _ManageInverterState();
}

class _ManageInverterState extends State<ManageInverter> {
  TextEditingController searched = TextEditingController();
  List<InverterModel> _searchlist = [];
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
    _searchlist.clear();
    searched.dispose();
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
          .where('Categoryname', isEqualTo: 'Inverter')
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
              _searchlist.add(InverterModel(
                id: element.get('id') ?? '',
                name: element.get('name') ?? '',
                type: element.get('type') ?? '',
                ratedpower: element.get('ratedpower') ?? 0,
                nominalvoltage: element.get('nominalvoltage') ?? 0,
                acvoltage: element.get('acvoltage') ?? 0,
                efficiency: element.get('efficiency') ?? 0,
                buyingprice: element.get('buyingprice') ?? 0,
                sellingprice: element.get('sellingprice') ?? 0,
                Categoryname: element.get('Categoryname'),
                description: element.get('description') ?? '',
                image: element.get('image') ?? '',
                addedday: element.get('addedday') ?? '',
                quantity: element.get('quantity') ?? 0,
              ));
            });
            _searchlist.toSet().toList();
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
          title: const Text(
            'Inverter',
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
                      return AddInverter(); // AddAppliances()
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
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    controller: searched,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search Inverter',
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
                                                    ManageInverterDetails(
                                                      inverter_converterModel:
                                                          _searchlist[index],
                                                    )));
                                      },
                                      child: InverterTiles(
                                        inverter_converterModel:
                                            _searchlist[index]!,
                                      ));
                                }),
                          )
                        : const NoData()
                    : StreamBuilder<List<InverterModel?>?>(
                        stream: DatabaseService().inverters,
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
                                                        ManageInverterDetails(
                                                          inverter_converterModel:
                                                              snapshot.data![
                                                                  index]!,
                                                        )));
                                          },
                                          child: InverterTiles(
                                            inverter_converterModel:
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
