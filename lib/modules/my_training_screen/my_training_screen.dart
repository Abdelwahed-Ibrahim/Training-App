import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/student_layout/cubit/cubit.dart';
import '../../layout/student_layout/cubit/states.dart';
import '../../shared/components/training_widget.dart';

class MyTrainingScreen extends StatelessWidget {
  const MyTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        StudentCubit cubit = StudentCubit.get(context, false);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                TrainingWidget(post: cubit.myTrainings[index]),
            itemCount: cubit.myTrainings.length,
          ),
        );
      },
    );
  }
}
