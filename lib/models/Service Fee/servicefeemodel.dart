
class ServiceFeeModel{
  String id;
  String name;
  String description;
  num installationfee;
  num maintenancefee;
  num transportfee;
  num additionalfee;

  ServiceFeeModel(
  {
    required this.id,
    required this.name,
    required this.description,
    required this.installationfee,
      required this.maintenancefee,
    required this.transportfee, required this.additionalfee, });
}