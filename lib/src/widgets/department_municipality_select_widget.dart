import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DepartmentMunicipalitySelectWidget extends StatefulWidget {
  const DepartmentMunicipalitySelectWidget({
    super.key,
    this.separation = 15,
    this.showIcons = false,
    this.departmentIcon = FontAwesomeIcons.earthAmericas,
    this.municipalityIcon = FontAwesomeIcons.earthAmericas,
    this.onDepartmentSelect,
    this.onMunicipalitySelect,
  });

  final bool showIcons;
  final IconData departmentIcon;
  final IconData municipalityIcon;
  final double separation;
  final void Function(int departmentID)? onDepartmentSelect;
  final void Function(int municipalityId)? onMunicipalitySelect;

  @override
  State<DepartmentMunicipalitySelectWidget> createState() =>
      _DepartmentMunicipalitySelectWidgetState();
}

class _DepartmentMunicipalitySelectWidgetState
    extends State<DepartmentMunicipalitySelectWidget> {
  int departmentId = 0;
  int municipalityId = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              if (widget.showIcons) ...[
                Icon(
                  widget.departmentIcon,
                  color: const Color(0XFF8B898A),
                ),
                SizedBox(
                  width: 17,
                ),
              ],
              Expanded(
                child: DropdownSearch<dynamic>(
                  validator: (dynamic department) {
                    //DepartmentModel
                    if (department == null) {
                      return "Seleccione un departamento";
                    } else {
                      return null;
                    }
                  },
                  // label: "Departamento",
                  // showSearch: true,
                  itemAsString: (dynamic department) {
                    return department['name'];
                  },
                  // dropdownSearchDecoration: InputDecoration(
                  //   contentPadding: EdgeInsets.all(0),
                  // ),
                  // onFind: (String filter) async {
                  //   var response = await Dio().get(
                  //     "$BASE_URL/departments",
                  //   );
                  //   print(response);
                  //   var models = DepartmentResponse.fromJson(response.data);
                  //   return models.data.toList();
                  // },
                  onChanged: (dynamic data) {
                    departmentId = data.id;
                    if (widget.onDepartmentSelect != null) {
                      widget.onDepartmentSelect!(data.id);
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: widget.separation,
          ),
          Row(
            children: [
              if (widget.showIcons) ...[
                Icon(
                  widget.municipalityIcon,
                  color: Color(0xff8b898a),
                ),
                SizedBox(
                  width: 17,
                ),
              ],
              Expanded(
                child: DropdownSearch<dynamic>(
                  validator: (dynamic municipality) {
                    //MunicipalityModel
                    if (municipality == null) {
                      return "Seleccione un municipio";
                    } else if (municipality.stateId != departmentId) {
                      return "El municipio no corresponde al departamento";
                    } else {
                      return null;
                    }
                  },
                  // label: "Municipio",
                  // showSearchBox: true,
                  itemAsString: (dynamic department) {
                    return department['name'];
                  },
                  // dropdownSearchDecoration: InputDecoration(
                  //   contentPadding: EdgeInsets.all(0),
                  // ),
                  // onFind: (String filter) async {
                  //   var response = await Dio()
                  //       .get("$BASE_URL/municipalities/$departmentId");

                  //   var models = MunicipalityResponse.fromJson(response.data);
                  //   return models.data.toList();
                  // },
                  onChanged: (dynamic data) {
                    if (widget.onMunicipalitySelect != null) {
                      widget.onMunicipalitySelect!(data.id);
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
