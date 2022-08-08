import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_ticker/constants/constant_colors.dart';
import 'package:todo_ticker/constants/constant_styles.dart';
import 'package:todo_ticker/constants/constant_widgets.dart';
import 'package:todo_ticker/constants/constants_strings.dart';
import 'package:todo_ticker/routes/routes.dart';
import 'package:todo_ticker/services/snackbar_service.dart';
import 'package:todo_ticker/view/widgets/tasks_grid_widget.dart';
import 'package:todo_ticker/view/widgets/tasks_list_widget.dart';
import 'package:todo_ticker/viewmodel/home_page_viewmodel.dart';

import '../getit/locator.dart';
import '../services/navigation_service.dart';

class HomePageView extends StatelessWidget
{
    HomePageView({Key? key}):super(key:key);
   late BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context =context;
    return ViewModelBuilder<HomePageViewModel>.reactive(
      onModelReady: (model){
        model.init();
      },
        viewModelBuilder: ()=> HomePageViewModel(),
        builder: (context,viewModel,child)
        {
          return Scaffold(
             backgroundColor: backgroundColor,
            body:  SafeArea(
              child: SizedBox(
                height: MediaQuery.of(_context).size.height,
                 width: MediaQuery.of(context).size.width,

                child: Stack(
                  children: [

                    SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 10,right: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            verticalSpace(30),
                            _headerPart(viewModel),
                            verticalSpace(30),
                           viewModel.tasksList.length>=1 ?    Flexible(child:viewModel.isGridView? TasksGridWidget() : TasksListWidget()) : _emptyList()

                          ],

                        ),
                      ),
                    ),

                    Positioned(
                        right: 1,
                        bottom: 1,
                        child:  Padding(
                          padding: const EdgeInsets.only(right:20.0,bottom: 30),
                          child: GestureDetector(
                            onTap: (){
                              if(viewModel.taskStatusList.where((element) => element.isStart == true).isEmpty) {
                                locator<NavigationService>().navigateTo(
                                    Routes.addTaskView);
                              }
                              else
                                {
                                  locator<SnackBarService>().showSnackBar(addTaskErrorMsg );
                                }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primaryColor
                              ),
                              height: 60,
                              width: 60,
                              child: const Center(child: Icon(Icons.add,color: secondaryColor,size: 48,)),


                            ),
                          ),
                        )),


                  ],
                ),
              ),
            ));




}
          );

  }

  Widget _emptyList()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Icon(Icons.hourglass_empty,size: 80,color: Colors.yellow,),

        verticalSpace(30),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("No Tasks Added \n"
              "Please add by tapping on floating button\n"
              "\n"
              ""
              "Once task is added you can tap tasks tile to start/pause your tasks.",style: mediumTextStyle.copyWith(color: secondaryColor),textAlign: TextAlign.center,),
        )

      ],
    );
  }
  Widget _headerPart(HomePageViewModel viewModel)
  {
    return Container(
      width: MediaQuery.of(_context).size.width*0.90,
      padding: const EdgeInsets.only(left:20,right: 20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(20),

      ),
      height: kToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(
            children: [
              const Icon(Icons.note,color: Colors.yellow,size: 32,),
              horizontalSpace(10),
              Text("ToDo Ticker",style: mediumTextStyle.copyWith(color: secondaryColor,fontWeight: FontWeight.w500),)

            ],
          ),

          GestureDetector(
              onTap: (){
                viewModel.toggleView();
              },
              child: Icon( !viewModel.isGridView? Icons.grid_view : Icons.list,size: 24,color: secondaryColor,))
        ],


      ),
    );
  }



}