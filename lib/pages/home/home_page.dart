import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import '../../components/app_button.dart';
import '../../config/app_colors.dart';
import '../../config/app_styles.dart';
import '../../models/user_model.dart';
import '../../services/firestore.dart';
import 'home_page_bloc.dart';
import 'need_chip.dart';
import 'need_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = HomePageBloc();

  @override
  void initState() {
    _bloc.nameController = TextEditingController();
    _bloc.phoneController = TextEditingController();
    _bloc.pageController = PageController(initialPage: 0);
    _bloc.getStream(Uri.base.queryParameters['uid'] ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: StreamBuilder<dynamic>(
        stream: _bloc.output,
        builder: (_, snapshot) {
          if (snapshot.hasData && snapshot.data is UserModel) {
            final UserModel user = snapshot.data;
            return Center(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: AppColors.primary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.fullName, style: AppStyles.bold(Sizes.s14, Colors.white)),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: List.generate(user.needs.length, (index) => NeedChip(need: user.needs[index])),
                        ),
                      ],
                    ),
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    firstCurve: Curves.easeInOut,
                    secondCurve: Curves.easeInOut,
                    firstChild: Container(
                      key: const ValueKey<int>(0),
                      padding: const EdgeInsets.all(20),
                      color: AppColors.background,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Posso ajudar com:', style: AppStyles.bold(Sizes.s14)),
                          const SizedBox(height: 10),
                          Column(
                            children: List.generate(_bloc.user.needs.length, (index) {
                              return NeedTile(
                                need: _bloc.user.needs[index],
                                setValue: (value) => setState(() => _bloc.user.needs[index].value = value),
                              );
                            }),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            style: AppStyles.regular(Sizes.s14),
                            decoration: AppDecorations.input('Seu nome'),
                            controller: _bloc.nameController,
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: AppStyles.regular(Sizes.s14),
                            decoration: AppDecorations.input('Seu telefone'),
                            controller: _bloc.phoneController,
                            onChanged: (_) => setState(() {}),
                            inputFormatters: [_bloc.mask],
                          ),
                          const SizedBox(height: 20),
                          AppButton(
                            color: AppColors.primary,
                            text: 'Pode contar comigo!',
                            enabled: _bloc.user.needs.map((e) => e.value == true).toList().contains(true) &&
                                _bloc.nameController.text.isNotEmpty &&
                                _bloc.phoneController.text.length == 15,
                            onTap: () async {
                              for (var i in _bloc.user.needs) {
                                if (i.value == true && i.blocked == false) {
                                  user.listOfMap.firstWhere((e) => e['name'] == i.name)['status'] = 'IN_PROGRESS';
                                }
                              }
                              await FirestoreService.updateUser(
                                askingHelpDocId: Uri.base.queryParameters['uid']!,
                                needs: user.listOfMap,
                                helperName: _bloc.nameController.text.trim(),
                                helperPhone: _bloc.phoneController.text.replaceAll(RegExp(r'[^0-9]'), ''),
                              );
                              setState(() => _bloc.index++);
                            },
                          ),
                        ],
                      ),
                    ),
                    secondChild: Container(
                      key: const ValueKey<int>(1),
                      padding: const EdgeInsets.all(20),
                      color: AppColors.background,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: SizedBox(
                              height: 250,
                              width: 250,
                              child: DotLottieLoader.fromAsset('lib/assets/dotlottie/animated_pin.json',
                                  frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                                if (dotlottie != null) {
                                  return Lottie.memory(dotlottie.animations.values.single);
                                } else {
                                  return Container();
                                }
                              }),
                            ),
                          ),
                          Text('OBRIGADO', style: AppStyles.bold(Sizes.s50)),
                          Text('Você faz a diferença!', style: AppStyles.bold(Sizes.s14)),
                          const SizedBox(height: 20),
                          AppButton(
                            color: AppColors.secondary,
                            text: 'Combinar a ajuda',
                            enabled: true,
                            onTap: () => _bloc.launch(_bloc.phoneController.text),
                          ),
                        ],
                      ),
                    ),
                    crossFadeState: _bloc.index == 1 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  )
                ],
              ),
            );
          }
          return const SpinKitRing(color: AppColors.primary, size: 80);
        },
      ),
    );
  }
}
