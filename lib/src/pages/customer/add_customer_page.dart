import 'dart:io';

import 'package:credimaster/src/helper/validations_functions.dart';
import 'package:credimaster/src/widgets/department_municipality_select_widget.dart';
import 'package:credimaster/src/widgets/validated_input_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCustomerPage extends StatelessWidget {
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar cliente"),
      ),
      body: const BodyAddClientWidget(),
    );
  }
}

class BodyAddClientWidget extends StatefulWidget {
  const BodyAddClientWidget({
    super.key,
  });

  @override
  State<BodyAddClientWidget> createState() => _BodyAddClientWidgetState();
}

class _BodyAddClientWidgetState extends State<BodyAddClientWidget> {
  // * Variables para controlar los inputs del form
  GlobalKey<FormState> form = GlobalKey<FormState>();
  // Inputs controller formulario cliente
  TextEditingController customerName = TextEditingController();
  TextEditingController profesion = TextEditingController();
  TextEditingController birthdate = TextEditingController();
  int departmentSelected = 0;
  int municipalitySelected = 0;
  TextEditingController customerAddress = TextEditingController();
  TextEditingController dui = MaskedTextController(mask: '00000000-0');
  TextEditingController nit = MaskedTextController(mask: '0000-000000-000-0');
  TextEditingController customerPhone = MaskedTextController(mask: '0000-0000');
  TextEditingController optionalCustomerPhone =
      MaskedTextController(mask: '0000-0000');
  TextEditingController customerEmail = TextEditingController();
  // Inputs controller formulario empresa cliente
  TextEditingController commerceName = TextEditingController();
  TextEditingController commerceActivity = TextEditingController();
  TextEditingController commerceAddress = TextEditingController();
  // Form Key referencia
  GlobalKey<FormState> formRelationship = GlobalKey<FormState>();
  // Inputs controllers formulario referencia
  TextEditingController relationshipaName = TextEditingController();
  TextEditingController relationshipPhone =
      MaskedTextController(mask: '0000-0000');
  int? idRelationship = 0;
  // Form Key documentos
  GlobalKey<FormState> formDocument = GlobalKey<FormState>();
  // Inputs controllers formulario documento
  TextEditingController nameDocument = TextEditingController();
  TextEditingController descriptionDocument = TextEditingController();
  final itemnReferences = []; //TODO: revisar
  final guarantee = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
            padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          _buildCardHeader(),
                          _buildCustomerPhotoSelect(),
                          _buildPersonalForm(context)
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text("¿Posee negocio?"),
                            children: [
                              ValidatedInput(
                                validator: commerceNameValidator,
                                controller: commerceName,
                                label: "Nombre del negocio",
                                icon: FontAwesomeIcons.store,
                              ),
                              ValidatedInput(
                                validator: commerceActivityValidator,
                                controller: commerceActivity,
                                label: "Actividad del negocio",
                                icon: FontAwesomeIcons.peopleCarryBox,
                              ),
                              ValidatedInput(
                                validator: commerceAddressValidator,
                                controller: commerceAddress,
                                label: "Dirección del negocio",
                                icon: FontAwesomeIcons.diamondTurnRight,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Referencias personales",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.userPlus),
                          onPressed: _showPersonalReferencesDialog,
                        )
                      ],
                    ),
                    const Divider(),
                    for (var r in itemnReferences)
                      ListTile(
                        trailing: IconButton(
                          icon: const Icon(FontAwesomeIcons.trashCan),
                          onPressed: () {
                            //    _addCustomerBloc.add(
                            //   RemoveReferenceEvent(reference: r),
                            // );
                          },
                        ),
                        leading: const Icon(FontAwesomeIcons.userGroup),
                        title: Text(r['name']),
                        subtitle: Text(r['phone']),
                      )
                    // BlocBuilder<AddCustomerBloc, AddCustomerState>(
                    //   builder: (BuildContext context, AddCustomerState state) {
                    //     return Column(
                    //       children: state.references
                    //           .map(
                    //             (r) => ,
                    //           )
                    //           .toList(),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Documentos y Garantias",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 55,
                          child: IconButton(
                              icon: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.image,
                                    size: 22,
                                  ),
                                  Icon(FontAwesomeIcons.plus, size: 12),
                                ],
                              ),
                              onPressed: _showDocumentsAndGuaranteesDialog),
                        )
                      ],
                    ),
                    const Divider(),
                    for (var w in guarantee)
                      ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            // _addCustomerBloc
                            //   .add(RemoveDocumentEvent(document: w);
                          },
                          icon: const Icon(FontAwesomeIcons.trashCan),
                        ),
                        leading: SizedBox(
                          width: 75,
                          height: 75,
                          child: Image.file(
                            w['photo'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(w['name']),
                        subtitle: Text(w['description']),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: TextButton(
                onPressed: () {
                  if (!form.currentState!.validate()) return;
      
                  // AddCustomerModel customer = AddCustomerModel((b) => b
                  //   ..name = customerName.text
                  //   ..profesion = profesion.text
                  //   ..birthDate = birthdate.text
                  //   ..departmentId = departmentSelected
                  //   ..municipalityId = municipalitySelected
                  //   ..address = customerAddress.text
                  //   ..dui = dui.text
                  //   ..nit = nit.text
                  //   ..phone = customerPhone.text
                  //   ..phone2 = optionalCustomerPhone.text
                  //   ..email = customerEmail.text
                  //   ..commerceName = commerceName.text
                  //   ..commerceActivity = commerceActivity.text
                  //   ..commerceAddres = commerceAddress.text);
      
                  // _addCustomerBloc
                  //     .add(SendCustomerDataEvent(customer: customer));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.solidFloppyDisk,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "REGISTRAR",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Column _buildCardHeader() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Registrar nuevo cliente"),
            Icon(
              FontAwesomeIcons.userPlus,
              size: 13,
            )
          ],
        ),
        Divider(),
      ],
    );
  }

  void _showDocumentsAndGuaranteesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Agregar documento o garantia",
            style: TextStyle(fontSize: 16),
          ),
          content: Form(
            key: formDocument,
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  GestureDetector(
                    onTap: _selectPictureWarranty,
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: const BoxDecoration(color: Colors.grey),
                      child: (true) //TODO:state.photoSelected
                          ? const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.image,
                                      color: Colors.white),
                                  Icon(FontAwesomeIcons.plus,
                                      color: Colors.white, size: 15),
                                ],
                              ),
                            )
                          // ignore: dead_code
                          : Image.file(
                              //TODO: REVISAR
                              File("state.tempPhoto"),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  ValidatedInput(
                    controller: nameDocument,
                    validator: nameValidator,
                    label: "Nombre",
                    icon: FontAwesomeIcons.image,
                  ),
                  ValidatedInput(
                    controller: descriptionDocument,
                    validator: documentDescriptionValidator,
                    label: "Descripion",
                    icon: FontAwesomeIcons.alignJustify,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: (true) //todo:state.photoSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    child: TextButton(
                      onPressed: (true) //todo:state.photoSelected
                          ? () {
                              if (!formDocument.currentState!.validate()) {
                                return;
                              }

                              // WarrantyModel warranty = WarrantyModel((b) => b
                              //   ..photo = state.tempPhoto
                              //   ..name = nameDocument.text
                              //   ..description = descriptionDocument.text);

                              // _addCustomerBloc
                              //     .add(AddWarrantyEvent(warranty: warranty));

                              nameDocument.clear();
                              descriptionDocument.clear();
                              Navigator.pop(context);
                            }
                          // ignore: dead_code
                          : null,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.solidFloppyDisk,
                              color: Colors.white),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "AGREGAR",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Column _buildCustomerPhotoSelect() {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text("Seleccionar fotografia"),
        const SizedBox(height: 10),
        Stack(
          children: [
            SizedBox(
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(360)),
                  width: 120,
                  height: 120,
                  child: //TODO:VER QUE AGREGAR AQUI
                      // (state.customerPhoto != null)
                      //     ? Image.file(
                      //         state.customerPhoto,
                      //         fit: BoxFit.cover,
                      //       )
                      //     :
                      const Icon(
                    FontAwesomeIcons.userLarge,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 25,
                child: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.camera,
                      color: Colors.white,
                    ),
                    onPressed: _selectPicture),
              ),
            )
          ],
        )
      ],
    );
  }

  void _selectPicture() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog( 
          children: [
            Wrap(
              children: [
                ListTile(
                  leading: const Icon(FontAwesomeIcons.camera),
                  title: const Text("Tomar foto"),
                  onTap: () {
                    // _addCustomerBloc
                    //     .add(PickCustomerPhoto(origin: ImageSource.camera));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.images),
                  title: const Text("Seleccionar de la galeria"),
                  onTap: () {
                    // _addCustomerBloc
                    //     .add(PickCustomerPhoto(origin: ImageSource.gallery));
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        );
      },
    );
  }

  Column _buildPersonalForm(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Información de personal"),
            Icon(
              FontAwesomeIcons.userLarge,
              size: 13,
            )
          ],
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ValidatedInput(
                validator: nameValidator,
                controller: customerName,
                label: "Nombre",
                icon: FontAwesomeIcons.userLarge,
              ),
              ValidatedInput(
                validator: profesionValidator,
                controller: profesion,
                label: "Profesión u oficio",
                icon: FontAwesomeIcons.userGraduate,
              ),
              TextFormField(
                readOnly: true,
                controller: birthdate,
                validator: (valor) {
                  return birthdateValidator(valor ?? "");
                },
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    birthdate.text = "${date.day}-${date.month}-${date.year}";
                  }
                },
                decoration: const InputDecoration(
                    icon: Icon(FontAwesomeIcons.calendarDay),
                    labelText: "Fecha de nacimiento"),
              ),
              DepartmentMunicipalitySelectWidget(
                onDepartmentSelect: (int departmentId) =>
                    departmentSelected = departmentId,
                onMunicipalitySelect: (int municipalityId) =>
                    municipalitySelected = municipalityId,
                showIcons: true,
              ),
              ValidatedInput(
                controller: customerAddress,
                validator: addressValidator,
                label: "Dirección",
                icon: FontAwesomeIcons.diamondTurnRight,
              ),
              ValidatedInput(
                validator: duiValidator,
                keyboardType: TextInputType.number,
                controller: dui,
                label: "DUI",
                icon: FontAwesomeIcons.idCard,
              ),
              ValidatedInput(
                validator: nitValidator,
                keyboardType: TextInputType.number,
                controller: nit,
                label: "NIT",
                icon: FontAwesomeIcons.idCard,
              ),
              ValidatedInput(
                validator: phoneValidator,
                keyboardType: TextInputType.phone,
                controller: customerPhone,
                label: "Teléfono 1",
                icon: FontAwesomeIcons.phoneFlip,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r"^[0-9-]+$"))
                ],
              ),
              ValidatedInput(
                validator: optionalPhoneValidator,
                controller: optionalCustomerPhone,
                label: "Teléfono 2",
                icon: FontAwesomeIcons.phoneFlip,
              ),
              ValidatedInput(
                validator: optionalEmailValidator,
                controller: customerEmail,
                keyboardType: TextInputType.emailAddress,
                formatType: InputFormatType.email,
                label: "Correo",
                icon: FontAwesomeIcons.at,
              ),
            ],
          ),
        )
      ],
    );
  }

  void _showPersonalReferencesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Agregar referencia personal",
            style: TextStyle(fontSize: 16),
          ),
          content: SingleChildScrollView(
            child: Form(
                key: formRelationship,
                child: Wrap(
                  children: [
                    ValidatedInput(
                      controller: relationshipaName,
                      validator: nameValidator,
                      label: "Nombre",
                      icon: FontAwesomeIcons.userLarge,
                    ),
                    ValidatedInput(
                      validator: phoneValidator,
                      keyboardType: TextInputType.phone,
                      controller: relationshipPhone,
                      label: "Telefono",
                      icon: FontAwesomeIcons.phoneFlip,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r"^[0-9-]+$"))
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.userGroup,
                          color: Color(0XFF8B898A),
                        ),
                        const SizedBox(width: 17),
                        Expanded(
                          child: DropdownSearch<dynamic>(
                            //RelationshipModel
                            validator: (dynamic department) {
                              if (department == null) {
                                return "Seleccione un parentesco";
                              } else {
                                return null;
                              }
                            },
                            // label: "Parentezco",
                            // showSearchBox: true,
                            itemAsString: (dynamic department) {
                              return department['name'];
                            },
                            // dropdownSearchDecoration: InputDecoration(
                            //   contentPadding: EdgeInsets.all(0),
                            // ),
                            // onFind: (String filter) async {
                            //   var response = await Dio().get(
                            //     "$BASE_URL/customers/relationships",
                            //   );

                            //   var models =
                            //       RelationshipResponse.fromJson(response.data);
                            //   return models.data.toList();
                            // },
                            onChanged: (dynamic value) {
                              idRelationship = value['id'];
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      child: TextButton(
                        onPressed: () {
                          if (!formRelationship.currentState!.validate()) {
                            return;
                          }

                          // ReferencesModel reference = ReferencesModel(
                          //   (b) => b
                          //     ..name = relationshipaName.text.toUpperCase()
                          //     ..phone = relationshipPhone.text.toUpperCase()
                          //     ..type = idRelationship,
                          // );

                          // _addCustomerBloc
                          //     .add(AddReferenceEvent(reference: reference));

                          relationshipaName.clear();
                          relationshipPhone.clear();
                          idRelationship = null;

                          Navigator.pop(context);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.solidSave,
                                color: Colors.white),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "AGREGAR",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  void _selectPictureWarranty() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Wrap(
            children: [
              ListTile(
                leading: const Icon(FontAwesomeIcons.camera),
                title: const Text("Tomar foto"),
                onTap: () {
                  // _addCustomerBloc
                  //     .add(PickWarrantyPhoto(origin: ImageSource.camera));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.images),
                title: const Text("Seleccionar de la galeria"),
                onTap: () {
                  // _addCustomerBloc
                  //     .add(PickWarrantyPhoto(origin: ImageSource.gallery));
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
