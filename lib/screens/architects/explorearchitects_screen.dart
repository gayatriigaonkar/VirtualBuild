import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:virtualbuild/widgets/architects/architectscard.dart';
import '../../providers/architects_provider.dart';
import '../../widgets/customdecorationforinput.dart';
import '../../widgets/custommenu.dart';
import '../../widgets/customscreen.dart';
import '../../widgets/headerwithmenu.dart';
import '../../widgets/housemodels/modelscard.dart';

class ExploreArchitectsScreen extends StatelessWidget {
  ExploreArchitectsScreen({super.key});

  static const routeName = "/explorearchitects";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var architectData = Provider.of<ArchitectsProvider>(context, listen: false);
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const CustomMenu(),
      body: MyCustomScreen(
        // customColor: Colors.blue,
        screenContent: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWithMenu(
              header: "Explore Architects",
              scaffoldKey: scaffoldKey,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: customDecorationForInput(
                      context,
                      "Search",
                      Icons.search,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: Theme.of(context).secondaryHeaderColor,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Flexible(
              child: ResponsiveGridList(
                rowMainAxisAlignment: MainAxisAlignment.end,
                minItemsPerRow: 1,
                minItemWidth: 300,
                listViewBuilderOptions: ListViewBuilderOptions(
                  padding: EdgeInsets.zero,
                ),
                children: List.generate(
                  architectData.getArchitects.length,
                  (index) => ArchitectsCard(
                    architectData: architectData.getArchitects[index],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
