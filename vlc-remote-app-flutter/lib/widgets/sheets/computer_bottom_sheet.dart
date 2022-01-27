import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/computer/computer.dart';
import '../../stores/files/files.dart';
import '../../utils/locale/app_locale.dart';
import '../../utils/regex.dart';
import '../../utils/sizer.dart';
import '../../utils/text_input_formatters/ip_text_input_formatter.dart';
import '../app_input.dart';
import 'app_bottom_sheet.dart';

class ComputerBottomSheet extends StatefulWidget {
    ComputerBottomSheet({
        this.computer,
        bool isScanned,
    }) : this.isScanned = isScanned ?? false;

    final Computer computer;
    final bool isScanned;

    @override
    _ComputerBottomSheetState createState() => _ComputerBottomSheetState();
}

class _ComputerBottomSheetState extends State<ComputerBottomSheet> {
    String name, ipAddress, vlcPort, password, companionPort;
    bool /*isButtonDisabled,*/ isDefault;

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    @override
    void initState() {
        name = widget.computer?.name;
        ipAddress = widget.computer?.ipAddress;
        vlcPort = widget.computer?.vlcPort;
        password = widget.computer?.password;
        companionPort = widget.computer?.companionPort ?? "27797";
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        Files files = Provider.of<Files>(context);
        if(isDefault == null) isDefault = widget.computer?.id == files.defaultComputerId || files.computers.length == 0;
        // TODO: autovalidate but not on first build or wait for it to be fixed https://github.com/flutter/flutter/pull/61648
        return AppBottomSheet(
            content: Form(
                key: _formKey,
                child: Column(
                    children: <Widget>[
                        AppInput(
                            labelText: locale.inputNameLabel,
                            hintText: locale.inputNameHint,
                            initialValue: name,
                            onChanged: (String value) {
                                name = value;
                                // setState(() => isButtonDisabled = _formKey.currentState.validate());
                            },
                            validator: (String value) => value.length > 0 ? null : locale.inputInvalidEmpty,
                        ),
                        Sizer.sizedBox(height: 10.0),
                        AppInput(
                            labelText: locale.inputIpLabel,
                            hintText: "127.0.0.0",
                            initialValue: ipAddress,
                            inputFormatters: [
                                IpTextInputFormatter(),
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (String value) {
                                ipAddress = value;
                                // setState(() => isButtonDisabled = _formKey.currentState.validate());
                            },
                            validator: (String value) => value.length == 0 ? locale.inputInvalidEmpty : (value.contains(ipRegex) ? null : locale.inputInvalidIp),
                        ),
                        Sizer.sizedBox(height: 10.0),
                        AppInput(
                            labelText: locale.inputVlcPortLabel,
                            hintText: "8080",
                            initialValue: vlcPort,
                            keyboardType: TextInputType.number,
                            onChanged: (String value) {
                                vlcPort = value;
                                // setState(() => isButtonDisabled = _formKey.currentState.validate());
                            },
                            validator: (String value) => value.length == 0 ? locale.inputInvalidEmpty : (value.contains(portRegex) ? null : locale.inputInvalidPort),
                        ),
                        Sizer.sizedBox(height: 10.0),
                        AppInput(
                            labelText: locale.inputPasswordLabel,
                            hintText: locale.inputPasswordHint,
                            initialValue: password,
                            obscureText: true,
                            onChanged: (String value) {
                                password = value;
                                // setState(() => isButtonDisabled = _formKey.currentState.validate());
                            },
                            validator: (String value) => value.length > 0 ? null : locale.inputInvalidEmpty,
                        ),
                        Sizer.sizedBox(height: 10.0),
                        AppInput(
                            labelText: locale.inputCompanionPortLabel,
                            hintText: "27797",
                            initialValue: companionPort,
                            keyboardType: TextInputType.number,
                            onChanged: (String value) {
                                companionPort = value;
                                // setState(() => isButtonDisabled = _formKey.currentState.validate());
                            },
                            validator: (String value) => value.length == 0 ? locale.inputInvalidEmpty : (value.contains(portRegex) ? null : locale.inputInvalidPort),
                        ),
                        Sizer.sizedBox(height: 10.0),
                        Row(
                            children: <Widget>[
                                Text(
                                    locale.switchUseByDefault,
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                ),
                                Switch(
                                    activeColor: Theme.of(context).colorScheme.primary,
                                    onChanged: (bool value) {
                                        isDefault = value;
                                        setState(() {});
                                    },
                                    value: isDefault,
                                ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        Sizer.sizedBox(height: 10.0),
                        Sizer.sizedBox(
                            child: FlatButton(
                                child: Text(locale.buttonSave),
                                color: Theme.of(context).colorScheme.primary,
                                disabledColor: Theme.of(context).colorScheme.primaryVariant,
                                onPressed: () {
                                    if(_formKey.currentState.validate()) {
                                        Computer computer;
                                        if(widget.computer == null || widget.isScanned) {
                                            computer = Computer(
                                                ipAddress: ipAddress,
                                                name: name,
                                                password: password,
                                                vlcPort: vlcPort,
                                                companionPort: companionPort,
                                            );
                                            files.addComputer(computer, isDefault);
                                        } else {
                                            computer = widget.computer;
                                            files.updateComputer(widget.computer.id, ipAddress, name, password, vlcPort, companionPort, isDefault);
                                        }
                                        Navigator.of(context).pop();
                                    }
                                },
                            ),
                            height: 25.0,
                            width: double.infinity,
                        ),
                    ],
                ),
            ),
        );
    }
}