import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
//collections...
const String adminsCollection = "admins";
const String globalCollection = "globals";
const String tempglobalCollection = "tempglobals";
const String appliancescategoryCollection = "appliancescategory";
const String equipmentscategoryCollection = "equipmentscategory";
const String customerCollection = "customers";
const String appointmentCollection = 'appointments';
const String appliancesCollection = "appliances";
const String equipmentCollection = 'equipments';
const String pvmoduleCollection = 'pvmodule';
const String financeCollection = 'finance';
const String servicecollection = 'servicefee';
const String tempservicecollection = 'tempservicefee';
const String accesscollection = 'accessories';
const String tempaccesscollection = 'tempaccessories';

const String city = 'city';
const String invoicecollection = 'invoice';
const String efficincy = 'efficincy';
const String batteryiconration = 'batteryiconration';
const String paneliconration = 'paneliconration';
const String tempappliances = 'tempappliances';
const String tempcalculation = 'tempequipments';
const String tempbattery = 'tempbattery';
const String temppanel = 'temppanel';
const String tempinverter = 'tempinverter';
const String tempcontroller = 'tempcontroller';

//App Constants
const appPadding = 16.0;
const String HomeRoute = "home";
const String MainRoute = "main";
const String AnalysisRoute = "analysis";
const String DashboardRoute = "dashboard";
const String LoginRoute = "login";
const String PageControllerRoute = "page";
const String CustomerRoute = "customer";
const String AgendaRoute = "agenda";
const String FinanceRoute = "finance";
const String InvoiceRoute = "invoice";
const String SettingsRoute = "settings";
const String EditAppliance = "editappliances";
const String EditCategory = "editcatories";
const String EditCustomers = 'editcustomers';
const String EditEquipments = "editequipments";
const String EditAdmin = "editadmins";
const String AdditionaSettings = 'addtionalsettings';
const String EditPvModule = 'editpvmodule';
final CollectionReference appliancescategoryreference =
    firebaseFiretore.collection(appliancescategoryCollection);
final CollectionReference adminrefference =
firebaseFiretore.collection(adminsCollection);

final CollectionReference accessrefference =
firebaseFiretore.collection(accesscollection);
final CollectionReference tempaccessrefference =
firebaseFiretore.collection(tempaccesscollection);
final CollectionReference servicerefference =
firebaseFiretore.collection(servicecollection);
final CollectionReference tempservicerefference =
firebaseFiretore.collection(tempservicecollection);
final CollectionReference tempglobalrefference =
firebaseFiretore.collection(tempglobalCollection);
final CollectionReference globalreference =
    firebaseFiretore.collection(globalCollection);
final CollectionReference equipmentscategoryreference =
    firebaseFiretore.collection(equipmentscategoryCollection);
final CollectionReference customerreferences =
    firebaseFiretore.collection(customerCollection);
final CollectionReference invoicereference =
    firebaseFiretore.collection(invoicecollection);
final CollectionReference appliancesreferences =
    firebaseFiretore.collection(appliancesCollection);
final CollectionReference equipmentreferences =
    firebaseFiretore.collection(equipmentCollection);
final CollectionReference cityreference = firebaseFiretore.collection(city);
final CollectionReference efficiencyreference =
    firebaseFiretore.collection(efficincy);
final CollectionReference financereference =
    firebaseFiretore.collection(financeCollection);
final CollectionReference batteryiconrationreference =
    firebaseFiretore.collection(batteryiconration);
final CollectionReference paneliconrationreference =
    firebaseFiretore.collection(paneliconration);
final CollectionReference tempappliancesrefference =
    firebaseFiretore.collection(tempappliances);
final CollectionReference tempbatteryreference =
    firebaseFiretore.collection(tempbattery);
final CollectionReference temppanelreference =
    firebaseFiretore.collection(temppanel);
final CollectionReference tempcalulationrefference =
    firebaseFiretore.collection(tempcalculation);
final CollectionReference appointmentrefference =
    firebaseFiretore.collection(appointmentCollection);
final CollectionReference tempinverterrefference =
    firebaseFiretore.collection(tempinverter);
final CollectionReference tempcontrollerrefference =
    firebaseFiretore.collection(tempcontroller);
