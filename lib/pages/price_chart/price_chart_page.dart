import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/models/change_price_model.dart';
import 'package:sigma/pages/price_chart/price_chart_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceChartPage extends StatelessWidget {
  PriceChartPage({super.key});

  String carModel = '';
  String imagePath = '';

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final String id = args['id'];

    carModel = args['carModel'];
    imagePath = args['imagePath'];

    final controller = Get.put(PriceChartController(id: id));
print(imagePath+carModel+id);
    return DarkBackgroundWidget(
        child: Obx(() => _buildBody(controller)), title: Strings.priceChange);
  }

  _buildBody(PriceChartController controller) {
    if (controller.isLoading.value) {
      return Center(
        child: loading(),
      );
    }
    return Column(
      children: [
        // Legend
       imagePath.isEmpty?SizedBox(): Padding(
         padding: const EdgeInsets.all(12.0),
         child: Image.network(
            imagePath ?? "",
            fit: BoxFit.contain,
            width: Get.width,
          ),
       ),
        SizedBox(height: 16,),
        CustomText(carModel,size: 16,fontWeight: FontWeight.bold),
        // Chart
        SizedBox(
          height: 450,
          child: SfCartesianChart(

            legend: Legend(isVisible: false),
            // Using custom legend above
            tooltipBehavior: TooltipBehavior(enable: true),
            primaryXAxis: CategoryAxis(
              labelRotation: -45,
              labelStyle: TextStyle(
                  color: Colors.white, // Dynamic month names color
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Peyda'),
            ),

            primaryYAxis: NumericAxis(
              minimum: 600000000,

              labelStyle: TextStyle(
                  color: Colors.white, // Dynamic month names color
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Peyda'),

              // title: AxisTitle(text: 'قیمت', textStyle: TextStyle(
              //   color: Colors.white, // Dynamic title color
              //   fontSize: 14,
              //   fontWeight: FontWeight.bold,
              //   fontFamily: 'Peyda'
              // ),),
              numberFormat: NumberFormat.currency(
                symbol: '',
                decimalDigits: 0,
                locale: 'fa',
              ),
            ),
            series: _buildSeries(controller),
            zoomPanBehavior: ZoomPanBehavior(
              enablePinching: true,
              enablePanning: true,
              enableDoubleTapZooming: true,
            ),
          ),
        ),
        _buildLegend(controller),
      ],
    );
  }

  Widget _buildLegend(PriceChartController controller) {
    return Wrap(
      spacing: 30,
      children: controller.yearDataList.map((yearData) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              yearData.year.toString().usePersianNumbers(),
            ),
            const SizedBox(width: 4),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: yearData.color,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  List<CartesianSeries> _buildSeries(PriceChartController controller) {
    return controller.yearDataList.map((yearData) {
      // فیلتر رو حذف کن - همه داده‌ها رو نگه دار
      return LineSeries<ChartData, String>(
        name: yearData.year.toString(),
        dataSource: yearData.data, // بدون فیلتر
        xValueMapper: (ChartData data, _) => data.month,
        yValueMapper: (ChartData data, _) => data.value == 0.0 ? null : data.value, // مقدار 0 رو به null تبدیل کن
        color: yearData.color,
        width: 2,
        markerSettings: MarkerSettings(
          isVisible: true,
          shape: DataMarkerType.circle,
          width: 6,
          height: 6,
          color: yearData.color,
          borderColor: Colors.white,
          borderWidth: 1,
        ),
        emptyPointSettings: EmptyPointSettings(
          mode: EmptyPointMode.gap,
        ),
        dataLabelSettings: const DataLabelSettings(
          isVisible: false,
        ),
      );
    }).toList();
  }
}
