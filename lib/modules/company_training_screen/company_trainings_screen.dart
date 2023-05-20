import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/company_layout/cubit/cubit.dart';
import '../../layout/company_layout/cubit/states.dart';
import '../../shared/components/training_widget.dart';

class CompanyTrainingsScreen extends StatelessWidget {
  const CompanyTrainingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CompanyCubit cubit = CompanyCubit.get(context, false);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                TrainingWidget(post: cubit.trainings[index]),
            itemCount: cubit.trainings.length,
          ),
        );
      },
    );
  }
}
