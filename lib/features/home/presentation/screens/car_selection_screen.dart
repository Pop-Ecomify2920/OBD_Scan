import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/utils/responsive.dart';

class CarSelectionScreen extends StatefulWidget {
  const CarSelectionScreen({super.key});

  @override
  State<CarSelectionScreen> createState() => _CarSelectionScreenState();
}

class _CarSelectionScreenState extends State<CarSelectionScreen> {
  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedModification;
  bool _isLoading = false;

  // Sample data - In production, this would come from a database/API
  final Map<String, List<String>> _brandModels = {
    'Audi': ['A3', 'A4', 'A6', 'Q5', 'Q7', 'e-tron', 'TT'],
    'BMW': ['3 Series', '5 Series', 'X3', 'X5', 'i3', 'iX'],
    'Mercedes-Benz': ['C-Class', 'E-Class', 'S-Class', 'GLC', 'GLE', 'EQC'],
    'Toyota': ['Camry', 'Corolla', 'RAV4', 'Highlander', 'Prius'],
    'Honda': ['Civic', 'Accord', 'CR-V', 'Pilot', 'Insight'],
    'Ford': ['F-150', 'Mustang', 'Explorer', 'Escape', 'Fusion'],
    'Volkswagen': ['Golf', 'Passat', 'Tiguan', 'Atlas', 'ID.4'],
    'Mitsubishi': ['Outlander', 'Eclipse Cross', 'X2', 'Lancer'],
  };

  final Map<String, List<String>> _modelModifications = {
    'Audi e-tron': ['50 quattro', '55 quattro', 'S'],
    'Audi A4': ['2.0 TFSI', '2.0 TDI', '3.0 TDI', 'S4'],
    'Audi A6': ['2.0 TFSI', '3.0 TFSI', '3.0 TDI', 'S6'],
    'BMW 3 Series': ['320i', '330i', '340i', 'M3'],
    'BMW 5 Series': ['520i', '530i', '540i', 'M5'],
    'Mercedes-Benz C-Class': ['C200', 'C300', 'C43 AMG', 'C63 AMG'],
    'Mercedes-Benz E-Class': ['E200', 'E300', 'E400', 'E63 AMG'],
    'Toyota Camry': ['LE', 'SE', 'XLE', 'XSE', 'TRD'],
    'Honda Civic': ['LX', 'EX', 'EX-L', 'Si', 'Type R'],
    'Mitsubishi X2': ['Base', 'Premium', 'Sport'],
  };

  List<String> get _availableModels {
    if (_selectedBrand == null) return [];
    return _brandModels[_selectedBrand] ?? [];
  }

  List<String> get _availableModifications {
    if (_selectedBrand == null || _selectedModel == null) return [];
    final key = '$_selectedBrand $_selectedModel';
    return _modelModifications[key] ?? ['Standard', 'Base', 'Premium'];
  }

  void _handleSave() async {
    if (_selectedBrand == null || _selectedModel == null || _selectedModification == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select Brand, Model, and Modification'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // TODO: Save car selection to local storage/database
    // TODO: Load PID mapping for selected car
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      // Navigate back or to home
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(RouteNames.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = Responsive.widthPercent(context, 10.5);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(193, 49, 49, 49),
              Color.fromARGB(169, 15, 15, 15),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Back button
              Positioned(
                top: Responsive.spacing(context, 10),
                left: Responsive.spacing(context, 20),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Container(
                  width: screenWidth,
                  constraints: BoxConstraints(
                    minHeight: screenHeight -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Top spacing
                      SizedBox(height: Responsive.spacing(context, 79)),

                      // Title
                      Text(
                        "Select Your Vehicle",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 30),
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(255, 255, 255, 1.0),
                          letterSpacing: 0.5,
                        ),
                      ),

                      // Subtitle
                      SizedBox(height: Responsive.spacing(context, 8)),
                      Text(
                        "Choose your car to enable correct PID mapping",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Responsive.fontSize(context, 13),
                          color: const Color.fromRGBO(255, 255, 255, 0.9),
                          height: 1.4,
                          letterSpacing: 0.3,
                        ),
                      ),

                      // Spacing to first dropdown
                      SizedBox(height: Responsive.spacing(context, 40)),

                      // Brand Selection
                      _buildDropdownField(
                        context,
                        label: "Brand",
                        value: _selectedBrand,
                        items: _brandModels.keys.toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedBrand = value;
                            _selectedModel = null; // Reset model when brand changes
                            _selectedModification = null; // Reset modification when brand changes
                          });
                        },
                        hint: "Select Brand",
                      ),

                      SizedBox(height: Responsive.spacing(context, 20)),

                      // Model Selection
                      _buildDropdownField(
                        context,
                        label: "Model",
                        value: _selectedModel,
                        items: _availableModels,
                        onChanged: _selectedBrand == null
                            ? null
                            : (String? value) {
                                setState(() {
                                  _selectedModel = value;
                                  _selectedModification = null; // Reset modification when model changes
                                });
                              },
                        hint: "Select Model",
                        enabled: _selectedBrand != null,
                      ),

                      SizedBox(height: Responsive.spacing(context, 20)),

                      // Modification Selection
                      _buildDropdownField(
                        context,
                        label: "Modification",
                        value: _selectedModification,
                        items: _availableModifications,
                        onChanged: (_selectedBrand == null || _selectedModel == null)
                            ? null
                            : (String? value) {
                                setState(() {
                                  _selectedModification = value;
                                });
                              },
                        hint: "Select Modification",
                        enabled: _selectedBrand != null && _selectedModel != null,
                      ),

                      // Spacing to Save button
                      SizedBox(height: Responsive.spacing(context, 50)),

                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: InkWell(
                          onTap: _isLoading ? null : _handleSave,
                          borderRadius: BorderRadius.circular(
                            Responsive.size(context, 10),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: Responsive.size(context, 48),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(19, 166, 222, 1.0),
                              borderRadius: BorderRadius.circular(
                                Responsive.size(context, 10),
                              ),
                            ),
                            padding: EdgeInsets.all(Responsive.spacing(context, 10)),
                            child: Center(
                              child: _isLoading
                                  ? SizedBox(
                                      width: Responsive.size(context, 20),
                                      height: Responsive.size(context, 20),
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Color.fromRGBO(255, 255, 255, 1.0),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "Save Selection",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: Responsive.fontSize(context, 15),
                                        color: const Color.fromRGBO(255, 255, 255, 1.0),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),

                      // Bottom spacing
                      SizedBox(height: Responsive.heightPercent(context, 10)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    BuildContext context, {
    required String label,
    String? value,
    required List<String> items,
    required ValueChanged<String?>? onChanged,
    required String hint,
    bool enabled = true,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Responsive.size(context, 10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Padding(
            padding: EdgeInsets.only(
              bottom: Responsive.spacing(context, 9),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Responsive.fontSize(context, 13),
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
            ),
          ),
          // Dropdown field
          Container(
            width: double.infinity,
            height: Responsive.size(context, 46),
            decoration: BoxDecoration(
              border: Border.all(
                color: enabled
                    ? const Color.fromRGBO(255, 255, 255, 1.0)
                    : const Color.fromRGBO(255, 255, 255, 0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                Responsive.size(context, 10),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.spacing(context, 20),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                isDense: true,
                hint: Text(
                  hint,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Responsive.fontSize(context, 11),
                    color: const Color.fromARGB(221, 255, 254, 254),
                  ),
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: Responsive.fontSize(context, 11),
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: enabled
                      ? const Color.fromRGBO(255, 255, 255, 1.0)
                      : const Color.fromRGBO(255, 255, 255, 0.5),
                  size: Responsive.size(context, 24),
                ),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: enabled ? onChanged : null,
                dropdownColor: const Color.fromRGBO(44, 44, 44, 1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

