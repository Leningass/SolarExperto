import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/models/finance/financemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constants/app_colors.dart';

class FinanceTile extends StatefulWidget {
  const FinanceTile({Key? key, required this.financeModel}) : super(key: key);
  final FinanceModel financeModel;

  @override
  State<FinanceTile> createState() => _FinanceTileState();
}

class _FinanceTileState extends State<FinanceTile> {
  List<FinanceModel> financeData = [];

  getDataFromDatabase() async {
    var value = FirebaseFirestore.instance;
    var getValue = value.collection(financeCollection).snapshots();
    return getValue;
  }

  @override
  void initState() {
    super.initState();
    getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
//child: _buildDataGrid(),
      /* child: DataTable(
       // headingRowColor:MaterialStateProperty.all(Colors.yellow),
        showBottomBorder: true,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey),
        //  borderRadius: BorderRadius.circular(20),

        ),
    //  dataRowColor: MaterialStateProperty.all(Colors.pink),
        columns: [
          DataColumn(label: Text('id')),
          DataColumn(label: Text('name')),
          DataColumn(label: Text('date')),
          DataColumn(label: Text('payment')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(widget.financeModel.id!)),
            DataCell(Text(widget.financeModel.name!)),
            DataCell(Text(widget.financeModel.date!)),
            DataCell(Text(widget.financeModel.payment! )),
          ])
        ],


      )*/

      /* ListTile(
        trailing: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Icon(Icons.arrow_forward_ios),
        ),
        title:
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(

                  widget.financeModel.name,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: AppColor.black,
                      fontWeight: FontWeight.w600),
                ),

                Text(
                  '${widget.financeModel.date}'
                  // '${ widget.invoiceModel.date} '

                  ,
                  style: TextStyle(
                    color: AppColor.black.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),


              ],
            ),
            Text(
              "${widget.financeModel.payment} ${String.fromCharCodes(Runes('\u0024'))}",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16
              ),
            )


          ],
        ),
      ),*/
    );
  }
}

class FinanceDataSource extends DataGridSource {
  FinanceDataSource(this.financedata) {
    _buildDataRow();
  }

  List<DataGridRow> _employeeData = [];
  List<FinanceModel?>? financedata;

  void _buildDataRow() {
    int index=1;
    _employeeData = financedata!
        .map<DataGridRow>((e) => DataGridRow(cells: [

              DataGridCell<int>(columnName: 'id', value: index++),
              DataGridCell<String>(columnName: 'name', value: e!.name),
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(columnName: 'payment', value: e.payment),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(
    DataGridRow row,
  ) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: SelectableText(e.value.toString()),
      );
    }).toList());
  }
}
