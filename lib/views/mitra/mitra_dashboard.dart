import 'package:WashWoosh/bloc/auth/login/login_bloc.dart';
import 'package:WashWoosh/bloc/mitra/mitra_dashboard/mitra_dashboard_bloc.dart';
import 'package:WashWoosh/bloc/mitra/mitra_detail/mitra_detail_bloc.dart';
import 'package:WashWoosh/data/models/mitra/mitra_laundry_membership_model.dart';
import 'package:WashWoosh/data/repositories/local/user_preferences.dart';
import 'package:WashWoosh/views/widgets/custom_loading.dart';
import 'package:WashWoosh/views/widgets/shimmer/laundry_list_shimmer.dart';
import 'package:WashWoosh/routes/routes.dart';
import 'package:WashWoosh/utils/date_formatter.dart';
import 'package:WashWoosh/views/widgets/custom_button.dart';
import 'package:WashWoosh/views/widgets/custom_pemesanan_popup.dart';
import 'package:WashWoosh/views/widgets/order_list_card.dart';
import 'package:WashWoosh/views/widgets/user_mini_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MitraDashboard extends StatefulWidget {
  const MitraDashboard({super.key});

  @override
  State<MitraDashboard> createState() => _MitraDashboardState();
}

class _MitraDashboardState extends State<MitraDashboard> {
  @override
  void initState() {
    super.initState();
    fetchDataMember();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        fetchOrderList();
      }
    });
  }

  List<MitraLaundryMembershipData> namaMember = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MitraDashboardBloc, MitraDashboardState>(
      builder: (context, state) {
        if (state is MitraDashboardFetchMember) {
          for (var i = 0; i < state.users.data.length; i++) {
            namaMember.add(state.users.data[i]);
          }
        }
        if (state is MitraDashboardLoading) {
          return const Scaffold(body: LaundryListShimmer());
        } else if (state is MitraDashboardFailure) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
        } else if (state is MitraDashboardSuccess) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                fetchOrderList();
              },
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 14, right: 14, top: 50),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: UserMiniProfileCard()
                                          .setImageProfile(
                                              "lib/assets/images/avatar_dummy.png")
                                          .setNameProfile(state.userData.nama)
                                          .setEmailProfile(state.userData.email)
                                          .build(context),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        final loginBloc =
                                            BlocProvider.of<LoginBloc>(context);
                                        loginBloc.add(LogoutButtonPressed());
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            AppRoutes.shadowPage,
                                            (Route<dynamic> route) => false);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.logout_rounded,
                                      size: 25,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Pesanan Terbaru",
                                      style: TextStyle(
                                          fontFamily: "Lato",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 0, bottom: 80),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.orderList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return OrderListCard()
                                  .setIdPemesanan(
                                      state.orderList[index].id.toString())
                                  .setLabel(state.orderList[index].customer.nama)
                                  .setOrderDate(DateFormatter.format(state
                                      .orderList[index].tanggalPesan
                                      .toString()))
                                  .setEstDate(DateFormatter.format(state
                                      .orderList[index].estimasiTanggalSelesai
                                      .toString()))
                                  .setTotal(
                                      state.orderList[index].harga.toString())
                                  .setStatus(
                                      state.orderList[index].statusPemesananId)
                                  .setOnTap(() {
                                _onOrderItemTap(
                                    context, state.orderList[index].id);
                              }).build(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomButton()
                          .setOnPressed(() async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24)),
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.8,
                                      child: CustomPemesananPopup(
                                        onDateSelected: (selectedDate) {},
                                        namaMember: namaMember,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          })
                          .setLabel("Tambah Laundry")
                          .build(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is AddOrderSuccess) {
          fetchOrderList();
        }
        if (state is AddOrderFailure) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
        }
        return const Scaffold(body: CustomLoading());
      },
    );
  }

  void fetchDataMember() async {
    final addLaundryBloc = BlocProvider.of<MitraDashboardBloc>(context);
    final token = await UserPreferences.getToken();
    addLaundryBloc.add(GetMitraMember(token: token['token']));
  }

  void fetchOrderList() async {
    final fetchOrderBloc = BlocProvider.of<MitraDashboardBloc>(context);
    final token = await UserPreferences.getToken();
    fetchOrderBloc.add(GetOrderList(token: token['token']));
  }

  void _onOrderItemTap(BuildContext context, int laundryId) async {
    final laundryListBloc = BlocProvider.of<MitraDetailBloc>(context);
    final token = await UserPreferences.getToken();
    print(laundryId);
    laundryListBloc
        .add(OrderListItemClicked(token: token['token'], laundryId: laundryId));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamed(context, AppRoutes.mitraDetailOrder);
    });
  }
}
