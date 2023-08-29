import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobileapp/provider/address_provider.dart';
import 'package:mobileapp/view/components/color.dart';
import 'package:provider/provider.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key});

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  final express = TextEditingController();
  final branch = TextEditingController();
  final username = TextEditingController();
  final phone = TextEditingController();
  final village = TextEditingController();
  final district = TextEditingController();
  final province = TextEditingController();
  Location location = new Location();
  BitmapDescriptor? icon;
  LocationData? _locationData;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  @override
  void initState() {
    super.initState();
    Provider.of<AddressProvider>(context, listen: false)..getByUser();
    getPermission();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), "assets/icons/pin.png")
        .then((value) {
      setState(() {
        icon = value;
      });
    });
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("MarkerId"),
          position: LatLng(_locationData!.latitude!, _locationData!.longitude!),
          icon: icon!,
          infoWindow:
              InfoWindow(title: "This is Title", snippet: "This is a snippet")),
    ].toSet();
  }

  Future<void> getPermission() async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      final locationData = await location.getLocation();
      setState(() {
        _locationData = locationData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (context, address, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColorWhite,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: primaryColorBlack,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "ເພີ່ມສະຖານທີ່ຈັດສົ່ງ",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColorBlack),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: InkWell(
          onTap: () async {
            await address.updateAddress(
              addressId: address.addressModel.id!,
              express: express.text.isEmpty
                  ? address.addressModel.express!
                  : express.text,
              branch: branch.text.isEmpty
                  ? address.addressModel.branch!
                  : branch.text,
              customer: username.text.isEmpty
                  ? address.addressModel.customer!
                  : username.text,
              phone: phone.text.isEmpty
                  ? address.addressModel.phone.toString()
                  : phone.text,
              village: village.text.isEmpty
                  ? address.addressModel.village!
                  : village.text,
              district: district.text.isEmpty
                  ? address.addressModel.district!
                  : district.text,
              province: province.text.isEmpty
                  ? address.addressModel.province!
                  : province.text,
              latitude: _locationData!.latitude.toString(),
              longitude: _locationData!.longitude.toString(),
            );
            if (address.success == true) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.bottomSlide,
                title: 'ສຳເລັດ',
                desc: 'ອັບເດດທີ່ຢູ່ສຳເລັດ',
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              )..show();
            } else {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.bottomSlide,
                title: 'ຜິດພາດ',
                desc: 'ອັບເດດທີ່ຢູ່ບໍ່ສຳເລັດ',
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              )..show();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: primaryColor),
              child: Center(
                child: Text(
                  "ອັບເດດທີ່ຢູ່",
                  style: TextStyle(
                      color: primaryColorWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text("ບໍລິສັດຂົນສົ່ງ"),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: address.addressModel.express,
                  onChanged: (value) {
                    setState(() {
                      value = express.text;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "ມີໄຊ,ຮຸງອາລຸນ,ອານຸສິດ...",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "express is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text("ສາຂາ"),
                TextFormField(
                  initialValue: address.addressModel.branch,
                    onChanged: (value) {
                    setState(() {
                      value = branch.text;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "ຫ້ວຍຫົງ,ດົງໂດກ,ຕານມີໄຊ",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "branch is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text("ຊື່ຜູ້ລູກຄ້າ"),
                TextFormField(
                  initialValue: address.addressModel.customer,
                  onChanged: (value) {
                    setState(() {
                      value = username.text;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "ທ້າວ ນາງ",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "username is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text("ເບີໂທຕິດຕໍ່"),
                TextFormField(
                  initialValue: address.addressModel.phone.toString(),
                    onChanged: (value) {
                    setState(() {
                      value = phone.text;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "020 030",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "phone is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text("ບ້ານຢູ່"),
                TextFormField(
                  initialValue: address.addressModel.village,
                    onChanged: (value) {
                    setState(() {
                      value = village.text;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "ຫ້ວຍຫົງ,ດົງໂດກ,ຕານມີໄຊ",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "village is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text("ເມືອງຢູ່"),
                TextFormField(
                  initialValue: address.addressModel.district,
                    onChanged: (value) {
                    setState(() {
                      value = district.text;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "ໄຊທານີ,ຈັນທະບູລີ...",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "district is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text("ແຂວງຢູ່"),
                TextFormField(
                  initialValue: address.addressModel.province,
                  onChanged: (value) {
                    setState(() {
                      value = province.text;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "ນະຄອນຫຼວງ,ຫຼວງພະບາງ",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "province is required";
                    }
                    return null;
                  },
                ),
                Text("ຕໍາແໜ່ງທີ່ຢູ່ປັດຈຸບັນ"),
                Container(
                  height: 200,
                  decoration: BoxDecoration(color: primaryColor),
                  child: _locationData == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                _locationData!.latitude!,
                                _locationData!.longitude!,
                              ),
                              zoom: 14),
                          myLocationEnabled: true,
                          markers: myMarker(),
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
