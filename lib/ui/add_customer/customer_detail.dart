import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:expense_money_manager/utils/assets_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerDetailPage extends StatefulWidget {
  final Map<String, dynamic> customer;

  CustomerDetailPage({required this.customer});

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  final TextEditingController _dateController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.primarylightColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      CupertinoIcons.back,
                      color: AppColors.white, // Back button color
                      size: 28,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  widget.customer["name"],
                  style: TextStyles().textStylePoppins(
                    size: 18,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Content Section
          Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              const SizedBox(height: 80),

              // Text(
              //   "Total Balance",
              //   //   "\$${customer["takenAmount"] - customer["givenAmount"]}",
              //   style: TextStyles().textStylePoppins(
              //     size: 14,
              //     color: AppColors.white,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Image.asset(AssetsPath.wallet, height: 24, width: 24),
              //     const SizedBox(width: 8),
              //     Text(
              //       "₹10,000",
              //       style: TextStyles().textStylePoppins(
              //         size: 20,
              //         color: AppColors.white,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 20),
              _buildTopCard(),
              _buildHistoryList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        children: [
          // Image.asset(AssetsPath.circlePerson2),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(
          //       customer["name"],
          //       style: TextStyles().textStylePoppins(
          //         size: 16,
          //         color: AppColors.black,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //
          //     Text(
          //       "📞 ${customer["phone"]}",
          //       style: TextStyles().textStylePoppins(
          //         size: 14,
          //         color: AppColors.grey,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 10),

          // **Transaction Summary Row**
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "total_in",
                        style: TextStyles().textStylePoppins(
                          size: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ).tr(),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            "₹${widget.customer["takenAmount"].toStringAsFixed(2)}",
                            style: TextStyles().textStylePoppins(
                              size: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // const SizedBox(width: 5),
                          Image.asset(
                            AssetsPath.arrow_down,
                            color: AppColors.green,
                            height: 20,
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8), // Spacing between cards

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "total_out",
                        style: TextStyles().textStylePoppins(
                          size: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ).tr(),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            "₹${widget.customer["givenAmount"].toStringAsFixed(2)}",
                            style: TextStyles().textStylePoppins(
                              size: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // const SizedBox(width: 5),
                          Image.asset(
                            AssetsPath.arrow_up,
                            color: AppColors.red,
                            height: 20,
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "pending_balance",
                  style: TextStyles().textStylePoppins(
                    size: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ).tr(),
                Text(
                  "₹${(widget.customer["takenAmount"] - widget.customer["givenAmount"]).toStringAsFixed(2)}",
                  style: TextStyles().textStylePoppins(
                    size: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // **Transaction History UI**
  Widget _buildHistoryList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "history",
                  style: TextStyles().textStylePoppins(
                    size: 18,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Icon(Icons.date_range_rounded),
                ),
              ],
            ),

            dummyHistory.isNotEmpty
                ? Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: dummyHistory.length,
                    itemBuilder: (context, index) {
                      return _historyItem(dummyHistory[index]);
                    },
                  ),
                )
                : Center(
                  child:
                      Text(
                        "no_transaction",
                        style: TextStyles().textStylePoppins(
                          size: 14,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ).tr(),
                ),
          ],
        ),
      ),
    );
  }

  Widget _historyItem(Map<String, dynamic> item) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      child: ListTile(
        // leading: Icon(item["icon"], color: AppColors.primaryColor),
        title: Text(
          item["title"],
          style: TextStyles().textStylePoppins(
            size: 14,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          item["subtitle"],
          style: TextStyles().textStylePoppins(
            size: 12,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "\$${item["amount"]}",
              style: TextStyles().textStylePoppins(
                size: 14,
                color: item["amount"] < 0 ? AppColors.red : AppColors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              item["date"] ?? "Unknown Date",
              style: TextStyles().textStylePoppins(
                size: 12,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> dummyHistory = [
  {
    "icon": Icons.shopping_cart,
    "title": "Supermarkets",
    "subtitle": "Grocery shopping",
    "amount": -140,
    "date": "2024-02-26",
  },
  {
    "icon": Icons.health_and_safety,
    "title": "Health and Beauty",
    "subtitle": "Salon visit",
    "amount": 322,
    "date": "2024-02-25",
  },
  {
    "icon": Icons.credit_card,
    "title": "Transfers from card",
    "subtitle": "Bank transfer",
    "amount": 427,
    "date": "2024-02-24",
  },
  {
    "icon": Icons.restaurant,
    "title": "Cafes and Restaurants",
    "subtitle": "Lunch with friends",
    "amount": 101,
    "date": "2024-02-23",
  },
  {
    "icon": Icons.more_horiz,
    "title": "The rest",
    "subtitle": "Miscellaneous",
    "amount": 10,
    "date": "2024-02-22",
  },
];
