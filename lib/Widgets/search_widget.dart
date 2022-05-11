import 'package:doctor_booking_application/Components/company_appbar.dart';
import 'package:doctor_booking_application/Components/divider.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

class SearchDisplayWidget extends StatelessWidget {
  final String title;
  final TextEditingController searchController;
  final Function setState;
  final Widget? child;
  final List<Widget> displayList;
  const SearchDisplayWidget(
      {required this.title,
      required this.setState,
      required this.searchController,
      this.child,
      required this.displayList,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 64),
        child: CompanyAppbar(
          title: title,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                flex: (child != null) ? 2 : 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 18,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => searchController.text = '',
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onChanged: (value) => setState(),
                      ),
                    ),
                    if (child != null)
                      Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Style.secondaryDark.withOpacity(0.32),
                            width: 0.87,
                          ),
                        ),
                        child: child,
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: (displayList.isEmpty)
                    ? Center(
                        child: Text(
                          'Oops, Empty List . . . ',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.black26,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) =>
                                  displayList[index],
                              separatorBuilder: (context, index) =>
                                  CustomDivider(),
                              itemCount: displayList.length,
                            ),
                          ),
                          26.height,
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
