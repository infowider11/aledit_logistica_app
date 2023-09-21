import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/constants/image_urls.dart';
import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/modals/order_list_model.dart';
import 'package:aledit_logistica/pages/side_drawer.dart';
import 'package:aledit_logistica/widgets/custom_loader.dart';
import 'package:aledit_logistica/widgets/custom_text.dart';
import 'package:aledit_logistica/widgets/input_text_field_widget.dart';
import 'package:aledit_logistica/widgets/order_info_card.dart';
import 'package:aledit_logistica/widgets/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/global_data.dart';
import '../functions/validation_functions.dart';
import '../providers/order_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldhomeKey = GlobalKey();
  TextEditingController orderIdController = TextEditingController();
  final orderIdFormKey = GlobalKey<FormState>();
  ValueNotifier<bool> pageLoading = ValueNotifier(false);
  ValueNotifier<bool> orderListLoading = ValueNotifier(true);
  ValueNotifier<OrderListModal> orderListNotifier =
      ValueNotifier<OrderListModal>(OrderListModal.fromJson({}));
  late TabController tabController;
  late OrderProvider orderProvider;
  @override
  void initState() {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      orderProvider = Provider.of<OrderProvider>(context, listen: false);
      // orderProvider.splashTimer(context);
      orderListNotifier.value =
          await orderProvider.getOrderList(context, load: orderListLoading);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldhomeKey,
      appBar: AppBar(
        leading: InkWell(
          onTap: () async {
            scaffoldhomeKey.currentState?.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
            child: Image.asset(MyImagesUrl.menuSideBar),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
            valueListenable: userDataNotifier,
            builder: (context, userData, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppBarHeadingText(
                    text: 'Good Morning,',
                    color: Colors.black,
                  ),
                  Expanded(
                      child: AppBarHeadingText(
                    text: ' ${userData?.user!.name}',
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ))
                ],
              );
            }),
      ),
      drawer: const CustomSideDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSizedBox2,
            Image.asset(
              MyImagesUrl.homePageStaticImage,
              width: MediaQuery.of(context).size.width,
            ),
            vSizedBox6,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Form(
                key: orderIdFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubHeadingText('Order ID'),
                    vSizedBox05,
                    const ParagraphText(
                      'Please enter your order id',
                      color: Colors.black54,
                    ),
                    vSizedBox,
                    CustomTextField(
                      controller: orderIdController,
                      hintText: '#53210ACD',
                      validator: ValidationFunction.orderIdValidation,
                    ),
                    vSizedBox2,
                    Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) {
                        return ValueListenableBuilder(
                          valueListenable: pageLoading,
                          builder: (context, pageLoadingValue, child) {
                            return RoundEdgedButton(
                              text: 'Process',
                              load: pageLoadingValue,
                              onTap: () async {
                                if (orderIdFormKey.currentState!.validate()) {
                                  pageLoading.value = true;
                                  orderProvider.getOrderDetail(context,
                                      orderId: orderIdController.text,
                                      load: pageLoading);
                                  // OrderModal orderModal = OrderModal(
                                  //     orderId: orderIdController.text,
                                  //     shippingStore: '1',
                                  //     noOfBoxes: 3);
                                }
                              },
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            DefaultTabController(
              length: 4,
              child: Builder(
                builder: (BuildContext context) => Column(
                  children: <Widget>[
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: IconTheme(
                        data: const IconThemeData(
                          size: 135.0,
                        ),
                        child: TabBar(
                          controller: tabController,
                          isScrollable: true,
                          unselectedLabelColor: MyColors.primaryColor,
                          labelColor: MyColors.whiteColor,
                          indicatorColor: MyColors.transparent,
                          // indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 1,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.primaryColor,
                          ),

                          labelPadding: EdgeInsets.symmetric(horizontal: 10),
                          // unselectedLabelStyle:,
                          tabs: [
                            Tab(
                              child: Container(
                                height: 45,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: MyColors.primaryColor,
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Pending",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              // text: 'Cancelled',
                              child: Container(
                                width: 80,
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: MyColors.primaryColor,
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'In Process',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              // text: 'Purchased',
                              child: Container(
                                width: 80,
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: MyColors.primaryColor,
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Shipping',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              // text: 'Purchased',
                              child: Container(
                                width: 80,
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: MyColors.primaryColor,
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Shipped',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: MyColors.whiteColor,
                      height: MediaQuery.of(context).size.height - 150,
                      padding: EdgeInsets.all(10),
                      child: TabBarView(controller: tabController, children: [
                        for (int i = 0; i < 4; i++)
                          ValueListenableBuilder<bool>(
                            valueListenable: orderListLoading,
                            builder: (context, pageload, child) => 
                                 Stack(
                                   children: [
                                     ValueListenableBuilder<OrderListModal>(
                                        valueListenable: orderListNotifier,
                                        builder: (context, orderList, child) => (pageload == false && (i ==
                                                        0 &&
                                                    orderList.pending.isEmpty ||
                                                i == 1 &&
                                                    orderList.inprocess.isEmpty ||
                                                i == 2 &&
                                                    orderList.shipping.isEmpty ||
                                                i == 3 && orderList.shipped.isEmpty))
                                            ? Container(
                                                alignment: Alignment.center,
                                                child:
                                                    SubHeadingText("No Data Found"),
                                              )
                                            : ListView.builder(
                                                itemCount: i == 0
                                                    ? orderList.pending.length
                                                    : i == 1
                                                        ? orderList.inprocess.length
                                                        : i == 2
                                                            ? orderList
                                                                .shipping.length
                                                            : orderList
                                                                .shipped.length,
                                                itemBuilder: (context, index) =>
                                                    OrderInfoCard(
                                                      orderListPageLoader : orderListLoading,
                                                      orderData: i == 0
                                                          ? orderList.pending[index]
                                                          : i == 1
                                                              ? orderList
                                                                  .inprocess[index]
                                                              : i == 2
                                                                  ? orderList
                                                                          .shipping[
                                                                      index]
                                                                  : orderList
                                                                          .shipped[
                                                                      index],
                                                    )),
                                      ),
                                      pageload
                                ? const CustomLoader():Container()
                                   ],
                                 ),
                          ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
