import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/about_app_model.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is ContactUsSuccessState) {
          showToast(
              message: 'Your Message Sent Successfully',
              state: TostStates.SUCCESS);
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var aboutModel = CustomerCubit.get(context).aboutAppModel?.data;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: ColorManager.mainOrange,
            title: Text(
              'Contact Us',
              style: TextStyles.font18White,
            ),
          ),
          body: Container(
            height: double.infinity,
            padding: const EdgeInsetsDirectional.only(
                end: 20.0, start: 20.0, top: 30.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/main_background.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get In Touch',
                    style: TextStyles.font30blackbold,
                  ),
                  verticalSpace(10),
                  Text(
                    'If you have any queries, get in touch with us. We will be happy to help you!',
                    style: TextStyles.font18Grey800bold,
                  ),
                  verticalSpace(20),
                  Form(
                    key: cubit.emailFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.title_outlined),
                          hintText: 'Subject',
                          controller: cubit.titleController,
                          isObsecureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Subject';
                            }
                            return null;
                          },
                        ),
                        verticalSpace(20),
                        CustomTextFormField(
                          borderRadius: BorderRadius.circular(10),
                          maxLines: 7,
                          hintText: 'Message',
                          controller: cubit.messageController,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(Icons.message),
                          isObsecureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Message';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(20),
                  AppTextButton(
                    buttonText: 'Send Message',
                    textStyle: TextStyles.font17WhiteBold,
                    onPressed: () {
                      if (cubit.emailFormKey.currentState!.validate()) {
                        cubit.contactUs(
                          subject: cubit.titleController.text,
                          message: cubit.messageController.text,
                        );
                      }
                    },
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      Text(
                        'Or you can contact us by ',
                        style: TextStyles.font15BlackBold,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (aboutModel != null) {
                            _sendEmail(aboutModel);
                          } else {
                            // Handle the case where aboutModel is null
                            debugPrint('aboutModel is null');
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.email,
                              color: ColorManager.mainOrange,
                            ),
                            Text(
                              'email...',
                              style: TextStyles.font15BlackBold.copyWith(
                                color: ColorManager.mainOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Column(
                    children: [
                      Text(
                        'Follow Us To See Hot Offers And New Features',
                        style: TextStyles.font15BlackBold,
                      ),
                      verticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildSocialMediaItem(
                            onTap: () {
                              if (aboutModel != null) {
                                launchFacebook(aboutModel);
                              } else {
                                // Handle the case where aboutModel is null
                                debugPrint('aboutModel is null');
                              }
                            },
                            image: 'assets/images/facebook.png',
                          ),
                          buildSocialMediaItem(
                            onTap: () {
                              if (aboutModel != null) {
                                launchTiktok(aboutModel);
                              } else {
                                // Handle the case where aboutModel is null
                                debugPrint('aboutModel is null');
                              }
                            },
                            image: 'assets/images/tiktok.png',
                          ),
                          buildSocialMediaItem(
                            onTap: () {
                              if (aboutModel != null) {
                                launchTwitter(aboutModel);
                              } else {
                                // Handle the case where aboutModel is null
                                debugPrint('aboutModel is null');
                              }
                            },
                            image: 'assets/images/X.png',
                          ),
                          buildSocialMediaItem(
                            onTap: () {
                              if (aboutModel != null) {
                                launchInstagram(aboutModel);
                              } else {
                                // Handle the case where aboutModel is null
                                debugPrint('aboutModel is null');
                              }
                            },
                            image: 'assets/images/instagram.png',
                          ),
                        ],
                      ),
                      verticalSpace(20),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> launchFacebook(List<Data> models) async {
    for (final model in models) {
      if (model.facebook != null) {
        final facebookUrl = Uri.parse(model.facebook!);
        if (await canLaunchUrl(facebookUrl)) {
          await launchUrl(facebookUrl);
        } else {
          debugPrint('Could not launch ${model.facebook}');
        }
      } else {
        // Handle the case where model.facebook is null
        debugPrint('model.facebook is null');
      }
    }
  }

  Future<void> launchInstagram(List<Data> models) async {
    for (final model in models) {
      if (model.instagram != null) {
        final instagramUrl = Uri.parse(model.instagram!);
        if (await canLaunchUrl(instagramUrl)) {
          await launchUrl(instagramUrl);
        } else {
          debugPrint('Could not launch ${model.instagram}');
        }
      } else {
        // Handle the case where model.facebook is null
        debugPrint('model.instagram is null');
      }
    }
  }

  Future<void> launchTiktok(List<Data> models) async {
    for (final model in models) {
      if (model.tiktok != null) {
        final tiktokUrl = Uri.parse(model.tiktok!);
        if (await canLaunchUrl(tiktokUrl)) {
          await launchUrl(tiktokUrl);
        } else {
          debugPrint('Could not launch ${model.tiktok}');
        }
      } else {
        // Handle the case where model.facebook is null
        debugPrint('model.tiktok is null');
      }
    }
  }

  Future<void> launchTwitter(List<Data> models) async {
    for (final model in models) {
      if (model.twitter != null) {
        final twitterUrl = Uri.parse(model.twitter!);
        if (await canLaunchUrl(twitterUrl)) {
          await launchUrl(twitterUrl);
        } else {
          debugPrint('Could not launch ${model.twitter}');
        }
      } else {
        // Handle the case where model.facebook is null
        debugPrint('model.twitter is null');
      }
    }
  }

  void _sendEmail(List<Data> models) async {
    for (final model in models) {
      if (model.supportEmail != null) {
        final Uri emailUri = Uri(
          scheme: 'mailto',
          path: '${model.supportEmail}',
          queryParameters: {
            'subject': '',
            'body': '',
          },
        );
        if (await canLaunchUrl(emailUri)) {
          await launchUrl(emailUri);
        } else {
          debugPrint('Could not launch $emailUri');
        }
      }
    }
  }

  Widget buildSocialMediaItem({required String image, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        image,
        width: 25,
      ),
    );
  }
}
