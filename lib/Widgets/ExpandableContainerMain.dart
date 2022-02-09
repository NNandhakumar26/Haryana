import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

import 'ColumnText.dart';

class ExpandContainerPage extends StatelessWidget {
  final Widget? title;

  final String eContFirst;
  final String eContSecond;
  final String desc;
  final List<ColumnText>? list;
  final String lastContainerValue;

  ExpandContainerPage({
    this.title,
    this.eContFirst = 'Details',
    this.eContSecond = '',
    this.desc = '',
    this.list,
    this.lastContainerValue = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Style.lightText.withOpacity(0.32),
          width: 0.87,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        //THE ROW ELEMENT OR PASS THE LIST OF WIDGETS AND SPREAD IT WITHIN THE ROW (MAINAXISALIGNMENT.SPACEBETWEEN)
        title: title ?? Container(),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        eContFirst,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Style.lightText.withOpacity(0.60),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        eContSecond,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Style.lightText.withOpacity(0.87),
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              letterSpacing: 0.4,
                            ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Style.primary.withOpacity(0.087),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: Style.primary.withOpacity(0.87),
                              size: 16,
                            ),
                            (desc != '')
                                ? Container(
                                    width: 260,
                                    height: 80,
                                    child: Text(
                                      desc,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Style.lightText
                                                .withOpacity(0.87),
                                            fontSize: 14,
                                          ),
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.fade,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'No Data Available',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black26,
                                            fontSize: 12,
                                          ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.36,
                    ),
                    scrollDirection: Axis.horizontal,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: (list != null) ? list!.length : 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        // color: Colors.amber.withOpacity(0.32),
                        padding: EdgeInsets.all(6),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: list![index],
                        ),
                      );
                    },
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       ColumnText(
                //         title: 'Status',
                //         subtitle1: 'Completed',
                //       ),
                //       ColumnText(
                //         title: 'ID Number',
                //         subtitle1: 'EKG10235',
                //       ),
                //     ],
                //   ),
                // ),
                // Expanded(
                //   flex: 1,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       ColumnText(
                //         title: 'Invoice Date',
                //         subtitle1: 'May 18 | 2021',
                //       ),
                //       ColumnText(
                //         title: 'Date Paid',
                //         subtitle1: 'June 26 | 2021',
                //       ),
                //     ],
                //   ),
                // ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  width: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Amount Due',
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Style.lightText.withOpacity(0.60),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                          ),
                          SizedBox(
                            // height: Get.height / 60,
                            height: MediaQuery.of(context).size.height / 60,
                          ),
                          Text(
                            '\u{20B9} $lastContainerValue',
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Style.lightText.withOpacity(0.87),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24,
                                    ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
