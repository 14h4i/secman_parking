import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/common/widgets/stateless/text_error.dart';
import 'package:secman_parking/modules/manager/blocs/manager_bloc.dart';

class InternalCardManagerPage extends StatefulWidget {
  const InternalCardManagerPage({Key? key}) : super(key: key);

  @override
  _InternalCardManagerPageState createState() =>
      _InternalCardManagerPageState();
}

class _InternalCardManagerPageState extends State<InternalCardManagerPage> {
  ManagerBloc? get bloc => BlocProvider.of<ManagerBloc>(context);

  @override
  void initState() {
    bloc!.add(GetInternalCards());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerBloc, ManagerState>(
      builder: (context, state) {
        Widget body = const Center(
          child: CircularProgressIndicator(),
        );
        if (state is GetInternalCardsFailure) {
          body = TextError(error: state.error);
        }
        if (state is GetInternalCardsSuccess) {
          final cards = state.internalCards;
          if (cards != null) {
            body = SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return Container(
                    color:
                        (index) % 2 != 0 ? Colors.grey.shade200 : Colors.white,
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      leading: Text('${index + 1}'),
                      title: Text('${cards[index].id}'),
                      trailing: Text('${cards[index].vehicleNumber}'),
                    ),
                  );
                },
              ),
            );
          } else {
            body = Container();
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Quản lý thẻ nội bộ'),
          ),
          body: body,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {},
          ),
        );
      },
    );
  }
}
