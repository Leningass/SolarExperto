import 'package:SolarExperto/extension/app_extensions.dart';
import 'package:SolarExperto/models/appointments/appointmentmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_responsive.dart';
import '../../constants/constants.dart';
import '../../global_widgets/Loading/saveloading.dart';
import '../../models/timemodel/TimeModel.dart';
import '../../services/database/database_service.dart';
import '../../widget/calendar_strip.dart';

class UpdateAppointment extends StatefulWidget {
  const UpdateAppointment({Key? key, required this.apointmentsModel}) : super(key: key);
final ApointmentsModel apointmentsModel;
  @override
  State<UpdateAppointment> createState() => _UpdateAppointmentState();
}

class _UpdateAppointmentState extends State<UpdateAppointment> {
  bool isadded = false;
  final appointmentform = GlobalKey<FormState>();
  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now().add(Duration(days: 30));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 0));
  int weeknumber = 0;
  int monthnumber = 0;
  String? selectedFrequency;
  String? to;
  String? from;
  TextEditingController customernameController = TextEditingController();
  TextEditingController customerphoneController = TextEditingController();
  TextEditingController customeraddressController = TextEditingController();
  TextEditingController customeremailController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  late List<TimeModel> timemodel;
  onSelect(data) {
    print("Selected Date -> $data");
    DateTime lastDayOfMonth = new DateTime(data.year, data.month + 1, 0);
    setState(() {

      selectedDate = data;
      weeknumber = selectedDate.weekOfMonth;
      monthnumber = lastDayOfMonth.month;
    });
  }

  onWeekSelect(data) {
    print("Selected week starting at -> $data");
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(
        monthName,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontStyle: FontStyle.italic,
        ),
      ),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
        decoration:
        BoxDecoration(shape: BoxShape.circle, color: AppColor.bgSideMenu),
      ),
      Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      )
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? AppColor.black : AppColor.black;
    TextStyle normalStyle = TextStyle(fontSize: (!AppResponsive.isMobile(context))? 14:10, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white);
    TextStyle dayNameStyle = TextStyle(fontSize: (!AppResponsive.isMobile(context))? 14:8, color: isSelectedDate ? Colors.white : AppColor.black);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    // if (isDateMarked == true) {
    //   _children.add(getMarkedIndicatorWidget());
    // }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
          color: !isSelectedDate ? Colors.transparent : AppColor.bgSideMenu,
          //borderRadius: BorderRadius.all(Radius.circular(60)),
          shape: BoxShape.circle),
      child: Column(
        children: _children,
      ),
    );
  }

  @override
  void initState() {
    customernameController.text=widget.apointmentsModel.customername;
    customerphoneController.text=widget.apointmentsModel.customerphone;
    customeraddressController.text=widget.apointmentsModel.customeraddress;
  customeremailController.text=widget.apointmentsModel.customeremail;
    detailController.text=widget.apointmentsModel.detail!;
    from=widget.apointmentsModel.from_time;
    to=widget.apointmentsModel.to_time;

    timemodel = [
      TimeModel(from: '9:00', to: '9:30'),
      TimeModel(from: '9:30', to: '10:00'),
      TimeModel(from: '10:00', to: '10:30'),
      TimeModel(from: '10:30', to: '11:00'),
      TimeModel(from: '11:00', to: '11:30'),
      TimeModel(from: '11:30', to: '12:00'),
      TimeModel(from: '12:00', to: '12:30'),
      TimeModel(from: '12:30', to: '13:00'),
      TimeModel(from: '13:00', to: '13:30'),
      TimeModel(from: '13:30', to: '14:00'),
      TimeModel(from: '14:00', to: '14:30'),
      TimeModel(from: '14:30', to: '15:00'),
      TimeModel(from: '15:00', to: '15:30'),
      TimeModel(from: '15:30', to: '16:00'),
      TimeModel(from: '16:00', to: '16:30'),
      TimeModel(from: '16:30', to: '17:00'),
      TimeModel(from: '17:00', to: '17:30'),
      TimeModel(from: '17:30', to: '18:00'),
      TimeModel(from: '18:00', to: '18:30'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: const Center(
          child: Text("Update Apppointments"),
        ),
        content: Container(
          color: AppColor.bgColor,
          width: (!AppResponsive.isMobile(context))
              ? 400
              : MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Form(
                key: appointmentform,
                child: ListView(
                  children: [
                    Container(
                        color: AppColor.bgColor,
                        child: CalendarStrip(
                          startDate: startDate,
                          endDate: endDate,
                          selectedDate: selectedDate,
                          onDateSelected: onSelect,
                          onWeekSelected: onWeekSelect,
                          dateTileBuilder: dateTileBuilder,
                          iconColor: AppColor.bgSideMenu,
                          monthNameWidget: _monthNameWidget,
                          containerHeight: (!AppResponsive.isMobile(context))
                              ? 100.0
                              : 100.0,
                          containerDecoration: BoxDecoration(
                            color: AppColor.yellow,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          addSwipeGesture: true,
                        )),
                    const SizedBox(
                      height: appPadding,
                    ),
                    Container(
                      color: AppColor.bgColor,
                      // change your height based on preference
                      height: 50,
                      width: double.infinity,
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: timemodel.length,
                        itemBuilder: (context, index) {
                          //bool isSelectedDate = timemodel[index].to.compareTo(index) == 0;
                          return Container(
                            padding: const EdgeInsets.only(
                                top: 2, left: 5, right: 5, bottom: 2),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(60)),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedFrequency = timemodel[index].from;
                                  to = timemodel[index].to;
                                  from = timemodel[index].from;
                                });
                                print('$to  $from');
                              },
                              child: Container(
                                height: 10,
                                width: 100,
                                decoration: (selectedFrequency ==
                                    timemodel[index].from)
                                    ? BoxDecoration(
                                    color: AppColor.bgSideMenu,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)))
                                    : BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black
                                            .withOpacity(0.3)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    timemodel[index].from,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: (selectedFrequency ==
                                            timemodel[index].from)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: appPadding,
                    ),
                    TextFormField(
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a name ' : null,
                      decoration: InputDecoration(
                        labelText: "Name",
                        hintText: "Name",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: customernameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLength: 12,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a number ' : null,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        hintText: "Phone",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: customerphoneController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(


                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Email",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: customeremailController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 5,
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter address ' : null,
                      decoration: InputDecoration(
                        labelText: "Address",
                        hintText: "Address",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: customeraddressController,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Details',
                        hintText: "Detail",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: detailController,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.close,
                              size: 16, color: AppColor.bgColor),
                          style:
                          ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          label: Text("Cancel",
                              style: TextStyle(color: AppColor.bgColor)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.add,
                              size: 16, color: AppColor.bgColor),
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.bgSideMenu),
                          onPressed: () async {
                            if (appointmentform.currentState!.validate()) {
                              await DatabaseService().updateappointments(
                                widget.apointmentsModel.id,
                                 selectedDate,
                                from.toString(),
                                to.toString(),
                                customernameController.text.toString(),
                                customerphoneController.text.toString(),
                                customeremailController.text.toString(),
                                customeraddressController.text.toString(),

                                detailController.text.toString(),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Updated!")));
                              Navigator.of(context).pop();
                              setState(() {
                                isadded = true;
                              });
                            }
                          },
                          label: Text(
                            "Update",
                            style: TextStyle(
                                color: AppColor.bgColor, fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    (isadded == true) ? const SaveLoading() : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
        //child: const AddCategories(),
      ),
    );
  }
}
