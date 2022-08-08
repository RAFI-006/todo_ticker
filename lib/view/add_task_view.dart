import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_ticker/constants/constant_colors.dart';
import 'package:todo_ticker/constants/constant_styles.dart';
import 'package:todo_ticker/constants/constant_widgets.dart';
import 'package:todo_ticker/constants/constants_strings.dart';
import 'package:todo_ticker/services/snackbar_service.dart';
import 'package:todo_ticker/viewmodel/add_tasks_viewmodel.dart';

import '../getit/locator.dart';

class AddTaskView extends StatelessWidget
{

  AddTaskView({Key? key}):super(key: key);
  late BuildContext _context;
  late AddTasksViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    _context =context;

    return ViewModelBuilder<AddTasksViewModel>.reactive(

        viewModelBuilder: ()=> AddTasksViewModel(),


        builder: (context,viewModel,child)
        {
          _viewModel =viewModel;
          return  Scaffold(
              backgroundColor: backgroundColor,
              bottomSheet: _bottomSheet(),
              body: SafeArea(
                child: Container(
                  margin: const EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(15),
                      _headerPart(),

                      verticalSpace(30),
                      _messageContainer(),
                      verticalSpace(30),


                      _title(),

                      verticalSpace(10),
                      Expanded(child: _description()),



                    ],

                  ),
                ),
              )

          );
        }

    );



  }

  Widget _title()
  {
    return Container(
      color: Colors.transparent,

      child: _titleFormField(),
    );
  }
  
  Widget _description()
  {
    return Container(
      color: Colors.transparent,
      child: _descriptionFormField(),
    );
  }
  
  Widget _headerPart()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [

        GestureDetector(
            onTap: (){
              Navigator.pop(_context);
            },

            child: const Icon(Icons.arrow_back,size: 24,color: secondaryColor,)),

        GestureDetector(
          onTap: (){

             showTimerDurationPicker(_context);
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [

                Text("${_viewModel.durationItem.first} : ${_viewModel.durationItem.last.length>1?_viewModel.durationItem.last : "0:${_viewModel.durationItem.last}"} ",style: mediumTextStyle.copyWith(color: secondaryColor),),
                horizontalSpace(10),
                const   Icon(Icons.timer,size: 24,color: secondaryColor,),
              ],
            ),
          ),
        )




      ],

    );
  }




  showTimerDurationPicker(BuildContext context) {
    return Picker(
        adapter: NumberPickerAdapter(data: [
          const NumberPickerColumn(begin: 0, end: 10),
          const NumberPickerColumn(begin: 0, end: 60),
        ]),
        delimiter: [
          PickerDelimiter(child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: const Text(":"),
          ))
        ],
        hideHeader: true,
        title: const Text("Select Duration"),
        onConfirm: (Picker picker, List value) {

        _viewModel.updateDuration(value);

        }
    ).showDialog(context);
  }


  Widget _messageContainer()
  {
    return Visibility(
      visible: true,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(

          border: Border.all(color:secondaryColor ),
          borderRadius: BorderRadius.circular(5)
        ),
        child:   Text(addTaskMsg,
          maxLines: null,
          style: bodyTextStyle.copyWith(color: secondaryColor),



        ),

      ),
    );
  }
  Widget _titleFormField()
  {
    return TextFormField(
      autofocus:false,
      maxLines: null,
      textInputAction: TextInputAction.next,
      controller: _viewModel.titleController,
      onFieldSubmitted: (value){
        },

      inputFormatters: [

        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_ ]')),
      ],
     
      keyboardType: TextInputType.text,

      style: mediumTextStyle.copyWith(color: secondaryColor),
      decoration: InputDecoration(
        border: InputBorder.none,
        labelStyle: mediumTextStyle.copyWith(color:secondaryColor),
        
        hintStyle:  mediumTextStyle.copyWith(color:secondaryColor),
        labelText: "Title",
        
      ),
    );
  }

  Widget _descriptionFormField()
  {
    return TextFormField(
      autofocus: false,
      maxLines: null,
      controller: _viewModel.descriptionController,

      inputFormatters: [

        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_ ]')),
      ],

      keyboardType: TextInputType.name,

      style: mediumTextStyle.copyWith(color: secondaryColor),
      decoration: InputDecoration(
        border: InputBorder.none,
        labelStyle: mediumTextStyle.copyWith(color:secondaryColor),

        hintStyle:  mediumTextStyle.copyWith(color:secondaryColor),
        labelText: "Description",

      ),
    );
  }
  
  Widget _bottomSheet()
  {
    return GestureDetector(
      onTap: (){
        if(_viewModel.titleController.text.isNotEmpty) {
          _viewModel.addTasks();
        }
        else
          {
            locator<SnackBarService>().showSnackBar(addTitleMsg);
          }
      },
      child: Container(
        height: kToolbarHeight,
        color: primaryColor,
        child:  Center(child: Text("Add",style: mediumTextStyle.copyWith(color:secondaryColor)),),

      ),
    );
  }
}