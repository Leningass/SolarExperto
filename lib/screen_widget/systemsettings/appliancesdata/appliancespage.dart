import 'package:SolarExperto/screen_widget/systemsettings/appliancesdata/allaplianes.dart';
import 'package:SolarExperto/screen_widget/systemsettings/categoriesdata/addappliancecategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../constants/constants.dart';
import '../../../global_widgets/Loading/loading.dart';
import '../../../global_widgets/nodata/noitems.dart';
import '../../../models/categories/categorymodel.dart';
import '../../../services/database/database_service.dart';


class Applianceslist extends StatefulWidget {
  const Applianceslist({Key? key}) : super(key: key);

  @override
  State<Applianceslist> createState() => _ApplianceslistState();
}

class _ApplianceslistState extends State<Applianceslist> {
  TextEditingController searched = TextEditingController();
  List<CategoryAppliancesModel> _searchlist = [];
  String name = '';
  Offset _tapPosition = Offset.zero;
  final adminform = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  bool _obscureText = true;
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
          .collection(appliancescategoryCollection)
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

              _searchlist.add(CategoryAppliancesModel(
                  id: element.get('id') ?? '',
                  name: element.get('name') ?? '',
                  addedday: element.get('addedday') ?? ''));

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

  void _getTapPosition(TapDownDetails tapPosition) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(tapPosition
          .globalPosition); // store the tap positon in offset variable
      print(_tapPosition);
    });
  }



  @override
  Widget build(BuildContext context) {
    return (!AppResponsive.isMobile(context))
        ? Container(
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
                  'Appliances',
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
                            return AddApplianceCategories();
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
              body: Column(
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
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Group',
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
                          ? GridView.builder(
                            itemCount: _searchlist.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                // key: widgetKey,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AllApliances(
                                                  categoryname:
                                                      _searchlist[index]
                                                          .name!)));
                                },

                                child: Container(
                                  height: 500,
                                  width: 500,
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius:
                                        BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    // crossAxisAlignment:
                                    // CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Image.asset(
                                        'assets/homeappliances.png',
                                        height: 60,
                                        width: 100,
                                      ),
                                      Text(
                                        _searchlist[index].name!,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            physics: NeverScrollableScrollPhysics(),
                            // to disable GridView's scrolling
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                          )
                          : yelloNoData()
                      : StreamBuilder<List<CategoryAppliancesModel?>?>(
                          stream: DatabaseService().aplliancecategory,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.length == 0) {
                                return Center(
                                  child: NoData(),
                                );
                              } else {
                                return Expanded(
                                  child: SingleChildScrollView(
                                      child: GridView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTapDown: (position) =>
                                            {_getTapPosition(position)},

                                        onLongPress: () async {
                                          final RenderObject? overlay =
                                              Overlay.of(context)
                                                  .context
                                                  .findRenderObject();

                                          final result = await showMenu(
                                              context: context,
                                              position: RelativeRect.fromRect(
                                                  Rect.fromLTWH(
                                                      _tapPosition.dx,
                                                      _tapPosition.dy,
                                                      100,
                                                      100),
                                                  Rect.fromLTWH(
                                                      0,
                                                      0,
                                                      overlay!.paintBounds.size
                                                          .width,
                                                      overlay.paintBounds.size
                                                          .height)),
                                              items: [
                                                const PopupMenuItem(
                                                  child: Text('Delete'),
                                                  value: 1,
                                                )
                                              ]);
                                          // perform action on selected menu item
                                          switch (result) {
                                            case 1:
                                              try {
                                                var respectsQuery = await FirebaseFirestore
                                                    .instance
                                                    .collection(appliancesCollection)
                                                    .where('categoryid',
                                                    isEqualTo: snapshot.data![index]!.name)
                                                    .get();

                                                var totalEquals = respectsQuery.size;
                                                if (totalEquals == 0) {
                                                  showCupertinoDialog(
                                                    context: context,
                                                    builder: (context) => CupertinoAlertDialog(
                                                      title: Text("Are you sure you want to delete this"),

                                                      actions: <Widget>[

                                                        CupertinoDialogAction(
                                                          child: Text("No",style: TextStyle(color: AppColor.bgSideMenu),),
                                                          onPressed: () => Navigator.of(context).pop(false),
                                                        ),
                                                        CupertinoDialogAction(
                                                            child: Text("Yes",style: TextStyle(color: AppColor.bgSideMenu),),
                                                            onPressed: ()async {

                                                              Navigator.of(
                                                                  context)
                                                                  .pop();
                                                              showDialog(
                                                                  context: context,
                                                                  barrierDismissible: false,
                                                                  builder: (dialogContext) {
                                                                    return StatefulBuilder(
                                                                        builder: (dialogContext, setState) {
                                                                          return AlertDialog(
                                                                            title: const Center(
                                                                              child: Text("Passcode"),
                                                                            ),
                                                                            content: Form(
                                                                                key: adminform,
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    TextFormField(
                                                                                      obscureText: _obscureText,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: "Enter passcode",
                                                                                        border: OutlineInputBorder(),
                                                                                        suffixIcon: IconButton(
                                                                                          color: Colors.grey,
                                                                                          onPressed: () {
                                                                                            setState(() {
                                                                                              _obscureText =
                                                                                              !_obscureText;
                                                                                            });
                                                                                          },
                                                                                          icon: Icon(
                                                                                            _obscureText
                                                                                                ? Icons.visibility
                                                                                                : Icons.visibility_off,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      controller: controller,
                                                                                      validator: (value) {
                                                                                        if (controller.text != null) {
                                                                                          if (value!.isEmpty) {
                                                                                            return 'Please enter passcode';
                                                                                          }
                                                                                        }
                                                                                      },
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment:
                                                                                      MainAxisAlignment.center,
                                                                                      children: [
                                                                                        ElevatedButton(
                                                                                            onPressed: () {
                                                                                              Navigator.of(
                                                                                                  dialogContext)
                                                                                                  .pop();
                                                                                              controller.clear();
                                                                                            },
                                                                                            style: ElevatedButton
                                                                                                .styleFrom(
                                                                                                backgroundColor:
                                                                                                Colors.red),
                                                                                            child: Text(
                                                                                              "Cancel",
                                                                                              style: TextStyle(
                                                                                                  color:
                                                                                                  AppColor.white),
                                                                                            )),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        ElevatedButton(
                                                                                            onPressed: () {
                                                                                              if (!adminform
                                                                                                  .currentState!
                                                                                                  .validate()) {
                                                                                              } else {
                                                                                                FirebaseFirestore
                                                                                                    .instance
                                                                                                    .collection(
                                                                                                    'passcode')
                                                                                                    .doc(
                                                                                                    'rKSpvQYw1CLpCekmqnFo')
                                                                                                    .get()
                                                                                                    .then(
                                                                                                        (DocumentSnapshot) async {
                                                                                                      if (controller
                                                                                                          .value.text ==
                                                                                                          DocumentSnapshot[
                                                                                                          'passcode']) {

                                                                                                        DatabaseService().deleteappliancecategory(snapshot.data![index]!.id);
                                                                                                        ScaffoldMessenger.of(dialogContext).showSnackBar(
                                                                                                            SnackBar(content: Text("Deleted!")));

                                                                                                        controller.clear();

                                                                                                        Navigator.of(
                                                                                                            dialogContext)
                                                                                                            .pop();
                                                                                                      } else {
                                                                                                        ScaffoldMessenger
                                                                                                            .of(dialogContext)
                                                                                                            .showSnackBar(
                                                                                                            SnackBar(
                                                                                                                content:
                                                                                                                Text("Just super admin can delete this!")));
                                                                                                        Navigator.of(
                                                                                                            dialogContext)
                                                                                                            .pop();
                                                                                                        controller.clear();
                                                                                                      }

                                                                                                      controller.clear();
                                                                                                    });
                                                                                              }
                                                                                            },
                                                                                            style: ElevatedButton
                                                                                                .styleFrom(
                                                                                                backgroundColor:
                                                                                                AppColor
                                                                                                    .bgSideMenu),
                                                                                            child: Text(
                                                                                              "Delete",
                                                                                              style: TextStyle(
                                                                                                  color:
                                                                                                  AppColor.white),
                                                                                            )),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                )),
                                                                          );
                                                                        });
                                                                  });






                                                              // Navigator.pushReplacement(context,
                                                              //     MaterialPageRoute(builder: (context) {
                                                              //       return ServiceFee();
                                                              //     }));
                                                            }
                                                        ),
                                                      ],
                                                    ),
                                                  );





                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text("You can't delete this category, first delete items")));

                                                }
                                              } catch (e) {}

                                              break;

                                          }
                                        },

                                        // key: widgetKey,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AllApliances(
                                                          categoryname: snapshot
                                                              .data![index]!
                                                              .name!)));
                                        },

                                        child: Container(
                                          height: 500,
                                          width: 500,
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // crossAxisAlignment:
                                            // CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.asset(
                                                'assets/homeappliances.png',
                                                height: 60,
                                                width: 100,
                                              ),
                                              Text(
                                                snapshot.data![index]!.name!,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    physics: NeverScrollableScrollPhysics(),
                                    // to disable GridView's scrolling
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                    ),
                                  )),
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
          )
        : Container(
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
                  'Appliances',
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
                            return AddApplianceCategories();
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
              body: Column(
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
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Group',
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
                          ? Expanded(
                              child: GridView.builder(
                                itemCount: _searchlist.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    // key: widgetKey,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllApliances(
                                                      categoryname:
                                                          _searchlist[index]
                                                              .name!)));
                                    },

                                    child: Container(
                                      height: 500,
                                      width: 500,
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // crossAxisAlignment:
                                        // CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Image.asset(
                                            'assets/homeappliances.png',
                                            height: 60,
                                            width: 100,
                                          ),
                                          Text(
                                            _searchlist[index].name!,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                physics: NeverScrollableScrollPhysics(),
                                // to disable GridView's scrolling
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                              ),
                            )
                          : yelloNoData()
                      : StreamBuilder<List<CategoryAppliancesModel?>?>(
                          stream: DatabaseService().aplliancecategory,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.length == 0) {
                                return Center(
                                  child: NoData(),
                                );
                              } else {
                                return Expanded(
                                  child: SingleChildScrollView(
                                      child: GridView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTapDown: (position) =>
                                            {_getTapPosition(position)},

                                        onLongPress: () async {
                                          final RenderObject? overlay =
                                              Overlay.of(context)
                                                  .context
                                                  .findRenderObject();

                                          final result = await showMenu(
                                              context: context,
                                              position: RelativeRect.fromRect(
                                                  Rect.fromLTWH(
                                                      _tapPosition.dx,
                                                      _tapPosition.dy,
                                                      100,
                                                      100),
                                                  Rect.fromLTWH(
                                                      0,
                                                      0,
                                                      overlay!.paintBounds.size
                                                          .width,
                                                      overlay.paintBounds.size
                                                          .height)),
                                              items: [
                                                const PopupMenuItem(
                                                  child: Text('Delete'),
                                                  value: 1,
                                                )
                                              ]);
                                          // perform action on selected menu item
                                          switch (result) {
                                            case 1:
                                              try {
                                                var respectsQuery = await FirebaseFirestore
                                                    .instance
                                                    .collection(appliancesCollection)
                                                    .where('categoryid',
                                                    isEqualTo: snapshot.data![index]!.name)
                                                    .get();

                                                var totalEquals = respectsQuery.size;
                                                if (totalEquals == 0) {
                                                  showCupertinoDialog(
                                                    context: context,
                                                    builder: (context) => CupertinoAlertDialog(
                                                      title: Text("Are you sure you want to delete this"),

                                                      actions: <Widget>[

                                                        CupertinoDialogAction(
                                                          child: Text("No",style: TextStyle(color: AppColor.bgSideMenu),),
                                                          onPressed: () => Navigator.of(context).pop(false),
                                                        ),
                                                        CupertinoDialogAction(
                                                            child: Text("Yes",style: TextStyle(color: AppColor.bgSideMenu),),
                                                            onPressed: ()async {

                                                                  Navigator.of(
                                                                      context)
                                                                      .pop();
                                                                  showDialog(
                                                                      context: context,
                                                                      barrierDismissible: false,
                                                                      builder: (dialogContext) {
                                                                        return StatefulBuilder(
                                                                            builder: (dialogContext, setState) {
                                                                              return AlertDialog(
                                                                                title: const Center(
                                                                                  child: Text("Passcode"),
                                                                                ),
                                                                                content: Form(
                                                                                    key: adminform,
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        TextFormField(
                                                                                          obscureText: _obscureText,
                                                                                          decoration: InputDecoration(
                                                                                            hintText: "Enter passcode",
                                                                                            border: OutlineInputBorder(),
                                                                                            suffixIcon: IconButton(
                                                                                              color: Colors.grey,
                                                                                              onPressed: () {
                                                                                                setState(() {
                                                                                                  _obscureText =
                                                                                                  !_obscureText;
                                                                                                });
                                                                                              },
                                                                                              icon: Icon(
                                                                                                _obscureText
                                                                                                    ? Icons.visibility
                                                                                                    : Icons.visibility_off,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          controller: controller,
                                                                                          validator: (value) {
                                                                                            if (controller.text != null) {
                                                                                              if (value!.isEmpty) {
                                                                                                return 'Please enter passcode';
                                                                                              }
                                                                                            }
                                                                                          },
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisAlignment:
                                                                                          MainAxisAlignment.center,
                                                                                          children: [
                                                                                            ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  Navigator.of(
                                                                                                      dialogContext)
                                                                                                      .pop();
                                                                                                  controller.clear();
                                                                                                },
                                                                                                style: ElevatedButton
                                                                                                    .styleFrom(
                                                                                                    backgroundColor:
                                                                                                    Colors.red),
                                                                                                child: Text(
                                                                                                  "Cancel",
                                                                                                  style: TextStyle(
                                                                                                      color:
                                                                                                      AppColor.white),
                                                                                                )),
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  if (!adminform
                                                                                                      .currentState!
                                                                                                      .validate()) {
                                                                                                  } else {
                                                                                                    FirebaseFirestore
                                                                                                        .instance
                                                                                                        .collection(
                                                                                                        'passcode')
                                                                                                        .doc(
                                                                                                        'rKSpvQYw1CLpCekmqnFo')
                                                                                                        .get()
                                                                                                        .then(
                                                                                                            (DocumentSnapshot) async {
                                                                                                          if (controller
                                                                                                              .value.text ==
                                                                                                              DocumentSnapshot[
                                                                                                              'passcode']) {

                                                                                                            DatabaseService().deleteappliancecategory(snapshot.data![index]!.id);
                                                                                                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                                                                                                                SnackBar(content: Text("Deleted!")));
                                                                                                            controller.clear();

                                                                                                            Navigator.of(
                                                                                                                dialogContext)
                                                                                                                .pop();
                                                                                                          } else {
                                                                                                            ScaffoldMessenger
                                                                                                                .of(dialogContext)
                                                                                                                .showSnackBar(
                                                                                                                SnackBar(
                                                                                                                    content:
                                                                                                                    Text("Just super admin can delete this!")));
                                                                                                            Navigator.of(
                                                                                                                dialogContext)
                                                                                                                .pop();
                                                                                                            controller.clear();
                                                                                                          }

                                                                                                          controller.clear();
                                                                                                        });
                                                                                                  }
                                                                                                },
                                                                                                style: ElevatedButton
                                                                                                    .styleFrom(
                                                                                                    backgroundColor:
                                                                                                    AppColor
                                                                                                        .bgSideMenu),
                                                                                                child: Text(
                                                                                                  "Delete",
                                                                                                  style: TextStyle(
                                                                                                      color:
                                                                                                      AppColor.white),
                                                                                                )),
                                                                                          ],
                                                                                        )
                                                                                      ],
                                                                                    )),
                                                                              );
                                                                            });
                                                                      });






                                                              // Navigator.pushReplacement(context,
                                                              //     MaterialPageRoute(builder: (context) {
                                                              //       return ServiceFee();
                                                              //     }));
                                                            }
                                                        ),
                                                      ],
                                                    ),
                                                  );





                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text("You can't delete this category, first delete items")));

                                                }
                                              } catch (e) {}

                                              break;

                                          }
                                        },

                                        // key: widgetKey,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AllApliances(
                                                          categoryname: snapshot
                                                              .data![index]!
                                                              .name!)));
                                        },

                                        child: Container(
                                          height: 500,
                                          width: 500,
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // crossAxisAlignment:
                                            // CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.asset(
                                                'assets/homeappliances.png',
                                                height: 60,
                                                width: 100,
                                              ),
                                              Text(
                                                snapshot.data![index]!.name!,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    physics: NeverScrollableScrollPhysics(),
                                    // to disable GridView's scrolling
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                  )),
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
          );
  }
}
