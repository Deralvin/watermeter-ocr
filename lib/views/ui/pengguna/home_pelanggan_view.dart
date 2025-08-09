import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:watermeterocr/const/color_pallete.dart';
import 'package:watermeterocr/views/ui/pengguna/controller/home_pelanggan_controller.dart';
import 'package:watermeterocr/views/ui/pengguna/detail_invoice_view.dart';

// class HomePelangganView extends StatefulWidget {
//   const HomePelangganView({super.key});

//   @override
//   State<HomePelangganView> createState() => _HomePelangganViewState();
// }

// class _HomePelangganViewState extends State<HomePelangganView> {
//   List datatagihan = [
//     {
//       "bulan": "Januari",
//       "tanggal": "12 Jan 2025",
//       "tagihan": "17744",
//     },
//     {
//       "bulan": "Februari",
//       "tanggal": "12 Feb 2025",
//       "tagihan": "6635",
//     },
//     {
//       "bulan": "Maret",
//       "tanggal": "12 Mar 2025",
//       "tagihan": "252",
//     },
//     {
//       "bulan": "April",
//       "tanggal": "12 Apr 2025",
//       "tagihan": "1231",
//     },
//     {
//       "bulan": "Mei",
//       "tanggal": "12 Mei 2025",
//       "tagihan": "21242",
//     },
//     {
//       "bulan": "Juni",
//       "tanggal": "12 Jun 2025",
//       "tagihan": "3124",
//     },
//     {
//       "bulan": "Juli",
//       "tanggal": "12 Jul 2025",
//       "tagihan": "12321",
//     },
//     {
//       "bulan": "Agustus",
//       "tanggal": "12 Agu 2025",
//       "tagihan": "1453",
//     },
//     {
//       "bulan": "September",
//       "tanggal": "12 Sep 2025",
//       "tagihan": "323212",
//     },
//     {
//       "bulan": "Oktober",
//       "tanggal": "12 Okt 2025",
//       "tagihan": "232",
//     },
//     {
//       "bulan": "November",
//       "tanggal": "12 Nov 2025",
//       "tagihan": "2311",
//     },
//     {
//       "bulan": "Desember",
//       "tanggal": "12 Des 2025",
//       "tagihan": "213",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: HomePelangganController(),
//       builder: (controller) => Scaffold(
//         body: controller.isLoading.value == true
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             :
// Column(
//                 children: [
//                   Gap(40.sp),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         "${controller.dashboard.value!.bulanIni}",
//                         style: TextStyle(fontSize: 28.sp),
//                       ),
//                       Icon(
//                         Icons.person_4_rounded,
//                         size: 40.sp,
//                       ),
//                       Gap(20.sp)
//                     ],
//                   ),
//                   Gap(20.sp),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(40.sp),
//                         decoration: BoxDecoration(
//                           color: ColorPallete().primayColor,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(20.sp),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text("Last Month"),
//                             Text("177 m3"),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(40.sp),
//                         decoration: BoxDecoration(
//                           color: ColorPallete().primayColor,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(20.sp),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text("This Month"),
//                             Text("196 m3"),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Gap(20.sp),
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 23.sp),
//                     padding: EdgeInsets.all(40.sp),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: ColorPallete().primayColor,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(20.sp),
//                       ),
//                     ),
//                     child: Text(
//                       "Selisih 19 m3",
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Gap(20.sp),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20.sp),
//                       padding: EdgeInsets.all(20.sp),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(20.sp),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "History",
//                                 style: TextStyle(
//                                   fontSize: 25.sp,
//                                 ),
//                               ),
//                               Text("2025"),
//                             ],
//                           ),
//                           Expanded(
//                             child: ListView.builder(
//                               itemCount: datatagihan.length,
//                               primary: true,
//                               itemBuilder: (context, index) => InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => DetailInvoiceView(),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   margin: EdgeInsets.only(bottom: 20.sp),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(999),
//                                       border: Border.all(
//                                         color: Colors.grey,
//                                       ),
//                                       color: Color(0xff9CABC2)),
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 8.sp, horizontal: 16.sp),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 datatagihan[index]['bulan'],
//                                                 style:
//                                                     TextStyle(fontSize: 20.sp),
//                                               ),
//                                               Text(
//                                                   "No. Tagihan ${datatagihan[index]['tagihan']}"),
//                                             ],
//                                           ),
//                                           SizedBox(width: 8),
//                                           Container(
//                                             margin: EdgeInsets.only(top: 4.sp),
//                                             child: Text(
//                                               datatagihan[index]['tanggal'],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Icon(
//                                         Icons.visibility,
//                                         color: Colors.black45,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Gap(20.sp),
//                 ],
//               ),
//       ),
//     );
//   }
// }

class HomePelangganView extends StatelessWidget {
  const HomePelangganView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePelangganController());

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.dashboard.value == null) {
          return const Center(child: Text("Data tidak tersedia"));
        }

        return Column(
          children: [
            Gap(40.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${controller.name}",
                  style: TextStyle(fontSize: 28.sp),
                ),
                Icon(
                  Icons.person_4_rounded,
                  size: 40.sp,
                ),
                Gap(20.sp)
              ],
            ),
            Gap(20.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(40.sp),
                  decoration: BoxDecoration(
                    color: ColorPallete().primayColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.sp),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Last Month"),
                      Text(
                          "${controller.convertCmToM(controller.dashboard.value!.bulanLalu!)} m3"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(40.sp),
                  decoration: BoxDecoration(
                    color: ColorPallete().primayColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.sp),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("This Month"),
                      Text(
                          "${controller.convertCmToM(controller.dashboard.value!.bulanIni!)} m3"),
                    ],
                  ),
                ),
              ],
            ),
            Gap(20.sp),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 23.sp),
              padding: EdgeInsets.all(40.sp),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorPallete().primayColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.sp),
                ),
              ),
              child: Text(
                "${controller.convertCmToM(controller.dashboard.value!.selisih!)} m3",
                textAlign: TextAlign.center,
              ),
            ),
            Gap(20.sp),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.sp),
                padding: EdgeInsets.all(20.sp),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.sp),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "History",
                          style: TextStyle(
                            fontSize: 25.sp,
                          ),
                        ),
                        DropdownButton<int>(
                          value: controller.selectedYear.value,
                          items: controller.yearList
                              .map((year) => DropdownMenuItem(
                                    value: year,
                                    child: Text(year.toString()),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.setYear(value);
                              controller.getHistoryBills(value);
                            }
                          },
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount:
                              controller.historyBills.value!.billsData!.length,
                          primary: true,
                          itemBuilder: (context, index) {
                            final indexingData = controller
                                .historyBills.value!.billsData![index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailInvoiceView(
                                      billsData: indexingData,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20.sp),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    color: Color(0xff9CABC2)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.sp, horizontal: 16.sp),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              indexingData.createdAt != null
                                                  ? DateFormat.MMMM().format(
                                                      indexingData.createdAt!)
                                                  : '-',
                                              style: TextStyle(fontSize: 20.sp),
                                            ),
                                            Text(
                                                "No. Tagihan ${indexingData.id}"),
                                          ],
                                        ),
                                        SizedBox(width: 8),
                                        Container(
                                          margin: EdgeInsets.only(top: 4.sp),
                                          child: Text(indexingData.createdAt !=
                                                  null
                                              ? DateFormat('d MMMM yyyy')
                                                  .format(
                                                      indexingData.createdAt!)
                                              : '-'),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.visibility,
                                      color: Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
            Gap(20.sp),
          ],
        );
      }),
    );
  }
}
