import 'package:SolarExperto/models/appliances/appliancemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../constants/constants.dart';
import '../../../global_widgets/header/editpage_header.dart';
import '../../../global_widgets/nodata/noitems.dart';
import '../../../models/categories/categorymodel.dart';
import '../../../pages/settings/manage_equipments_details/manageappliancedertail.dart';
import '../../../services/database/database_service.dart';
import '../../../global_widgets/Loading/loading.dart';
import 'addappliances.dart';
import 'appliancestiles.dart';

class AllApliances extends StatefulWidget {
  const AllApliances({Key? key, required this.categoryname}) : super(key: key);
  final String categoryname;

  @override
  State<AllApliances> createState() => _AllApliancesState();
}

class _AllApliancesState extends State<AllApliances> {
  TextEditingController searched = TextEditingController();
  List<ApplianceModel> _searchlist = [];
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
          .collection(appliancesCollection)
          .where('categoryid', isEqualTo: widget.categoryname)
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

              _searchlist.add(ApplianceModel(
                  id: element.get('id'),
                  name: element.get('name'),
                  categoryid: element.get('categoryid'),
                  type: element.get('type'),
                  ratedwattage: element.get('ratedwattage'),
                  timeofusage: element.get('timeofusage'),
                  quatity: element.get('quatity'),
                  image: element.get('image'),
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
            widget.categoryname,
          ),
          actions: [
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: AppColor.bgColor,
                padding: EdgeInsets.all(20.0),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) {
                      return AddAppliances(
                        categoryname: widget.categoryname,
                      );
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
                      hintText: 'Search Appliances',
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
                Container(
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: (name != '')
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
                                              (!AppResponsive.isMobile(context))
                                                  ? MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width /
                                                      2
                                                  : 390,
                                          childAspectRatio:
                                              (!AppResponsive.isMobile(context))
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
                                                      ManageApplianceDetails(
                                                        applianceModel:
                                                            _searchlist[index]!,
                                                      )));
                                        },
                                        child: AppliancesTiles(
                                          applianceModel: _searchlist[index]!,
                                        ));
                                  }),
                            )
                          : const NoData()
                      : StreamBuilder<List<ApplianceModel?>?>(
                          stream: DatabaseService(doctoken: widget.categoryname)
                              .appliances,
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
                                                          ManageApplianceDetails(
                                                            applianceModel:
                                                                snapshot.data![
                                                                    index]!,
                                                          )));
                                            },
                                            child: AppliancesTiles(
                                              applianceModel:
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
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
