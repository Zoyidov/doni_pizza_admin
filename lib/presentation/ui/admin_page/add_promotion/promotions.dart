import 'package:cached_network_image/cached_network_image.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/add_promotion/add_promotion.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/global_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:doni_pizza_admin/business_logic/promotion_bloc/promotion_bloc.dart';

class Promotions extends StatefulWidget {
  const Promotions({super.key});

  @override
  State<Promotions> createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Reklama Banneri',
            style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<PromotionBloc, PromotionState>(
        builder: (context, state) {
          if (state is PromotionLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          } else if (state is PromotionLoaded) {
            if (kDebugMode) {
              print(state.promotions.length);
            }
            return state.promotions.isEmpty
                ? const Center(
                    child: Text(
                    'Reklama Banneri mavjud emas',
                  ))
                : ListView.separated(
                    itemCount: state.promotions.length,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      final promotion = state.promotions[index];
                      return ZoomTapAnimation(
                          onLongTap: () {
                            GlobalDialog.show(
                              context: context,
                              title: 'O\'chirish',
                              message: 'Haqiqatdan ham o\'chirmoqchimisiz?',
                              buttonYes: 'Ha',
                              buttonNo: 'Yo\'q',
                              onYesPressed: () {
                                context.read<PromotionBloc>().add(DeletePromotion(promotion.id));
                                Navigator.pop(context);
                              },
                              onNoPressed: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all()),
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(imageUrl: promotion.imageUrl),
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Gap(10);
                    },
                  );
          } else if (state is PromotionError) {
            return Center(child: Text(state.error));
          }
          return Center(child: Text(state.toString()));
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addPromotion',
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewPromotion()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
