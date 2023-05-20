import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/loading_widget.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'drawer/my_drawer.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  void initState() {
    BlocProvider.of<CompanyCubit>(context).getCompanyInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CompanyCubit cubit = CompanyCubit.get(context);
        return cubit.company == null
            ? const Scaffold(
                body: LoadingWidget(label: 'Waiting for your information'),
              )
            : Scaffold(
                appBar: AppBar(
                  elevation: .50,
                  title: Text(cubit.titles[cubit.currentIndex]),
                ),
                drawer: const MyDrawer(),
                body: cubit.screen[cubit.currentIndex],
              );
      },
    );
  }
}
