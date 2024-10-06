import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/global_widgets/header/header_widget.dart';
import 'package:SolarExperto/models/appointments/appointmentmodel.dart';
import 'package:SolarExperto/pages/agenda/apointmentdetail.dart';
import 'package:SolarExperto/provider/app_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_responsive.dart';
import '../../constants/constants.dart';
import '../../global_widgets/Loading/loading.dart';
import '../../global_widgets/nodata/noitems.dart';
import '../../models/customers/customermodel.dart';
import '../../services/database/database_service.dart';
import 'addappointment.dart';
import 'appointtile.dart';

class Agenda extends StatefulWidget {
  const Agenda({Key? key}) : super(key: key);

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  TextEditingController searched = TextEditingController();
  List<ApointmentsModel> _searchlist = [];
  String name = '';
  String customername='';
  String customerid='';
  String customerphone='';
  String customercity='';
  String customeraddress='';
  String customeremail='';
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
          .collection(appointmentCollection)
          .orderBy('customername')
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

              _searchlist.add(ApointmentsModel(
                  id: element.get('id'),
                  date: element.get('date'),
                  from_time: element.get('from_time'),
                  to_time: element.get('to_time'),
                  customername: element.get('customername'),
                  customerphone: element.get('customerphone'),
                  customeraddress: element.get('customeraddress'),
                  customeremail: element.get('customeremail'),
                  detail: element.get('detail')));

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
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          /// Header Part
          const HeaderWidget(Routname: "Agenda"),
          SizedBox(
            height: appPadding,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Appointments',
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
                                        return const AddAppointments();
                                      });
                                },
                                child: Center(
                                  child: Text(
                                    'Add Appointments',
                                    style: TextStyle(
                                      color: AppColor.bgColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
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
                                hintText: 'Search Appointments',
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
                                  ? ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _searchlist.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ManageAppointmentDetails(
                                                          apointmentsModel:
                                                              _searchlist[
                                                                  index],
                                                        )));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            child: AppointmentTiles(
                                              apointmentsModel:
                                                  _searchlist[index],
                                            ),
                                          ),
                                        );
                                      })
                                  : const yelloNoData()
                              : StreamBuilder<List<ApointmentsModel?>?>(
                                  stream: DatabaseService().appointments,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.length == 0) {
                                        return Center(
                                          child: yelloNoData(),
                                        );
                                      } else {
                                        return ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              return StreamBuilder<
                                                  List<ApointmentsModel?>?>(
                                                stream: DatabaseService(
                                                        doctoken: snapshot
                                                            .data![index]!)
                                                    .appointments,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (snapshot.data!.length ==
                                                        0) {
                                                      return Center(
                                                        child: Text(
                                                            'No Equipments'),
                                                      );
                                                    } else {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ManageAppointmentDetails(
                                                                            apointmentsModel:
                                                                                snapshot.data![index]!,
                                                                          )));
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child:
                                                              AppointmentTiles(
                                                            apointmentsModel:
                                                                snapshot.data![
                                                                    index]!,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    return const Center(
                                                      child: Loading(),
                                                    );
                                                  }
                                                },
                                              );
                                            });
                                      }
                                    } else {
                                      return const Center(
                                        child: Loading(),
                                      );
                                    }
                                  },
                                )

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
          ),
        ],
      ),
    );
  }
}
