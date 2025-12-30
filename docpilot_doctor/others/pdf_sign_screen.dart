// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'dart:developer' as developer;
// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:package_info_plus/package_info_plus.dart';

// class PdfSignScreen extends StatefulWidget {
//   const  PdfSignScreen({super.key});

//   @override
//   State<PdfSignScreen> createState() => _PdfSignScreenState();
// }

// class _PdfSignScreenState extends State<PdfSignScreen> {
//   File? _selectedPdf;
//   String? _signedPdfPath;
//   final TextEditingController _patientNameController =
//       TextEditingController(text: 'John Doe');
//   final TextEditingController _patientAgeController =
//       TextEditingController(text: '45');
//   final TextEditingController _doctorNameController =
//       TextEditingController(text: 'Dr. Jaideep Prasad');
//   final TextEditingController _diagnosisController =
//       TextEditingController(text: 'Hypertension');

//   @override
//   void dispose() {
//     _patientNameController.dispose();
//     _patientAgeController.dispose();
//     _doctorNameController.dispose();
//     _diagnosisController.dispose();
//     super.dispose();
//   }

//   void _showErrorSnackBar(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> _pickPdf() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       setState(() {
//         _selectedPdf = File(result.files.single.path!);
//       });
//     }
//   }

//   Future<File?> _generatePrescriptionPdf() async {
//     try {
//       // Create a new PDF document
//       final PdfDocument document = PdfDocument();

//       // Add a page to the document
//       final PdfPage page = document.pages.add();

//       // Create a PDF graphics for the page
//       final PdfGraphics graphics = page.graphics;

//       // Create fonts
//       final PdfFont headerFont = PdfStandardFont(PdfFontFamily.helvetica, 18,
//           style: PdfFontStyle.bold);
//       final PdfFont titleFont = PdfStandardFont(PdfFontFamily.helvetica, 14,
//           style: PdfFontStyle.bold);
//       final PdfFont normalFont = PdfStandardFont(PdfFontFamily.helvetica, 12);
//       final PdfFont smallFont = PdfStandardFont(PdfFontFamily.helvetica, 10);
//       final PdfFont boldFont = PdfStandardFont(PdfFontFamily.helvetica, 12,
//           style: PdfFontStyle.bold);

//       // Draw header
//       graphics.drawString(
//         'DocPilot Medical Center',
//         headerFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 140)),
//         bounds: const Rect.fromLTWH(0, 10, 500, 30),
//         format: PdfStringFormat(alignment: PdfTextAlignment.center),
//       );

//       graphics.drawString(
//         '123 Health Street, Medical District, 54321',
//         smallFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         bounds: const Rect.fromLTWH(0, 40, 500, 20),
//         format: PdfStringFormat(alignment: PdfTextAlignment.center),
//       );

//       graphics.drawString(
//         'Phone: (123) 456-7890 | Email: info@docpilot.com',
//         smallFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         bounds: const Rect.fromLTWH(0, 60, 500, 20),
//         format: PdfStringFormat(alignment: PdfTextAlignment.center),
//       );

//       // Draw a line separator
//       graphics.drawLine(
//         PdfPen(PdfColor(0, 0, 0), width: 1),
//         const Offset(50, 90),
//         const Offset(550, 90),
//       );

//       // Draw prescription title
//       graphics.drawString(
//         'PRESCRIPTION',
//         titleFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         bounds: const Rect.fromLTWH(0, 110, 500, 30),
//         format: PdfStringFormat(alignment: PdfTextAlignment.center),
//       );

//       // Patient information table
//       final PdfGrid patientInfoTable = PdfGrid();
//       patientInfoTable.style = PdfGridStyle(
//         font: normalFont,
//         cellPadding: PdfPaddings(left: 10, right: 10, top: 5, bottom: 5),
//       );

//       patientInfoTable.columns.add(count: 2);
//       patientInfoTable.headers.add(1);

//       final PdfGridRow headerRow = patientInfoTable.headers[0];
//       headerRow.cells[0].value = 'Patient Information';
//       headerRow.cells[0].columnSpan = 2;
//       headerRow.style.font = boldFont;
//       headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(220, 220, 220));

//       // Add patient details
//       PdfGridRow row = patientInfoTable.rows.add();
//       row.cells[0].value = 'Name:';
//       row.cells[1].value = _patientNameController.text;

//       row = patientInfoTable.rows.add();
//       row.cells[0].value = 'Age:';
//       row.cells[1].value = '${_patientAgeController.text} years';

//       row = patientInfoTable.rows.add();
//       row.cells[0].value = 'Date:';
//       row.cells[1].value = DateTime.now().toString().split(' ')[0];

//       row = patientInfoTable.rows.add();
//       row.cells[0].value = 'Diagnosis:';
//       row.cells[1].value = _diagnosisController.text;

//       // Draw the table
//       PdfLayoutResult patientInfoResult = patientInfoTable.draw(
//         page: page,
//         bounds: const Rect.fromLTWH(50, 150, 500, 0),
//       )!;

//       // Medication table
//       final PdfGrid medicationTable = PdfGrid();
//       medicationTable.style = PdfGridStyle(
//         font: normalFont,
//         cellPadding: PdfPaddings(left: 10, right: 10, top: 5, bottom: 5),
//       );

//       medicationTable.columns.add(count: 3);
//       medicationTable.headers.add(1);

//       final PdfGridRow medHeaderRow = medicationTable.headers[0];
//       medHeaderRow.cells[0].value = 'Prescribed Medications';
//       medHeaderRow.cells[0].columnSpan = 3;
//       medHeaderRow.style.font = boldFont;
//       medHeaderRow.style.backgroundBrush =
//           PdfSolidBrush(PdfColor(220, 220, 220));

//       // Add column headers
//       row = medicationTable.rows.add();
//       row.cells[0].value = 'Medication';
//       row.cells[1].value = 'Dosage';
//       row.cells[2].value = 'Instructions';
//       row.style.font = boldFont;

//       // Sample medications
//       final List<List<String>> medications = [
//         ['Amlodipine', '5mg', 'Take one tablet daily'],
//         ['Hydrochlorothiazide', '12.5mg', 'Take one tablet in the morning'],
//         ['Atorvastatin', '10mg', 'Take one tablet at bedtime'],
//       ];

//       // Add medications to table
//       for (final medication in medications) {
//         row = medicationTable.rows.add();
//         row.cells[0].value = medication[0];
//         row.cells[1].value = medication[1];
//         row.cells[2].value = medication[2];
//       }

//       // Set column widths
//       medicationTable.columns[0].width = 150;
//       medicationTable.columns[1].width = 100;

//       // Draw the medication table
//       PdfLayoutResult medicationResult = medicationTable.draw(
//         page: page,
//         bounds: Rect.fromLTWH(50, patientInfoResult.bounds.bottom + 30, 500, 0),
//       )!;

//       // Follow-up information
//       final PdfGrid followUpTable = PdfGrid();
//       followUpTable.style = PdfGridStyle(
//         font: normalFont,
//         cellPadding: PdfPaddings(left: 10, right: 10, top: 5, bottom: 5),
//       );

//       followUpTable.columns.add(count: 1);
//       followUpTable.headers.add(1);

//       final PdfGridRow followUpHeaderRow = followUpTable.headers[0];
//       followUpHeaderRow.cells[0].value = 'Follow-up Instructions';
//       followUpHeaderRow.style.font = boldFont;
//       followUpHeaderRow.style.backgroundBrush =
//           PdfSolidBrush(PdfColor(220, 220, 220));

//       row = followUpTable.rows.add();
//       row.cells[0].value = 'Please schedule a follow-up visit in 2 weeks.';

//       // Draw the follow-up table
//       PdfLayoutResult followUpResult = followUpTable.draw(
//         page: page,
//         bounds: Rect.fromLTWH(50, medicationResult.bounds.bottom + 30, 500, 0),
//       )!;

//       // Draw doctor signature section
//       final double signatureY = followUpResult.bounds.bottom + 50;

//       graphics.drawString(
//         'Doctor: ${_doctorNameController.text}',
//         normalFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         bounds: Rect.fromLTWH(300, signatureY, 200, 20),
//       );

//       graphics.drawString(
//         'Digital Signature: Pending',
//         smallFont,
//         brush: PdfSolidBrush(PdfColor(100, 100, 100)),
//         bounds: Rect.fromLTWH(300, signatureY + 30, 200, 20),
//       );

//       // Get the documents directory
//       final documentsPath = await _getDocumentsPath();
//       if (documentsPath == null) {
//         throw 'Could not access Documents folder';
//       }

//       // Save the document
//       final String filename =
//           'prescription_${DateTime.now().millisecondsSinceEpoch}.pdf';
//       final String path = '$documentsPath${Platform.pathSeparator}$filename';
//       final File file = File(path);
//       await file.writeAsBytes(await document.save());

//       // Dispose the document
//       document.dispose();

//       setState(() {
//         _selectedPdf = file;
//       });

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Prescription PDF generated successfully'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }

//       return file;
//     } catch (e) {
//       developer.log(
//         'Error generating prescription PDF',
//         error: e,
//         name: 'PdfSignScreen',
//       );
//       _showErrorSnackBar('Error generating prescription PDF: $e');
//       return null;
//     }
//   }

//   Future<List<int>> _loadCertificate() async {
//     try {
//       final ByteData data =
//           await rootBundle.load('assets/certs/certificate.pfx');
//       if (data.lengthInBytes == 0) {
//         throw 'Certificate file is empty';
//       }

//       // Get the raw bytes without any offset manipulation
//       final List<int> certBytes = List<int>.from(data.buffer.asUint8List());

//       // Basic validation of certificate format
//       if (certBytes.length < 16) {
//         // PKCS12 files should be larger than this
//         throw 'Invalid certificate: File too small';
//       }

//       try {
//         // Try loading the certificate without accessing properties
//         PdfCertificate(certBytes, 'docpilot123');
//       } catch (e) {
//         developer.log(
//           'Certificate loading failed',
//           error: e,
//           name: 'PdfSignScreen',
//         );
//         rethrow;
//       }

//       return certBytes;
//     } on FlutterError catch (e) {
//       developer.log('Asset loading error', error: e, name: 'PdfSignScreen');
//       throw 'Certificate not found in assets: $e';
//     } catch (e) {
//       developer.log('Certificate error', error: e, name: 'PdfSignScreen');
//       throw 'Certificate error: $e';
//     }
//   }

//   Future<void> _signPdf() async {
//     if (_selectedPdf == null) {
//       _showErrorSnackBar('Please select or generate a PDF file');
//       return;
//     }

//     PdfDocument? document;
//     try {
//       if (!await _selectedPdf!.exists()) {
//         _showErrorSnackBar('Selected PDF file no longer exists');
//         return;
//       }

//       final pdfBytes = await _selectedPdf!.readAsBytes();
//       if (pdfBytes.isEmpty) {
//         _showErrorSnackBar('Selected PDF file is empty');
//         return;
//       }

//       try {
//         document = PdfDocument(inputBytes: pdfBytes);
//         if (document.pages.count == 0) {
//           throw 'PDF document has no pages';
//         }

//         final List<int> certificateBytes = await _loadCertificate();

//         // Create signature field
//         final PdfSignatureField signatureField = PdfSignatureField(
//           document.pages[0],
//           'Signature',
//           bounds: const Rect.fromLTWH(50, 50, 400, 100),
//         );

//         // Set up the signature with the certificate
//         signatureField.signature = PdfSignature(
//           certificate: PdfCertificate(certificateBytes, 'docpilot123'),
//           reason: 'Prescription signed by ${_doctorNameController.text}',
//           contactInfo: 'Contact here babay',
//           signedDate: DateTime.now(),
//           locationInfo: 'Signed in DocPilot',
//           signedName: _doctorNameController.text,
//           digestAlgorithm: DigestAlgorithm.sha256,
//           cryptographicStandard: CryptographicStandard.cades,
//         );

//         // Add signature field to form
//         document.form.fields.add(signatureField);

//         // Save the document
//         final List<int> bytes = await document.save();
//         if (bytes.isEmpty) {
//           throw 'Failed to generate signed PDF: Output is empty';
//         }

//         // Get the documents directory
//         final documentsPath = await _getDocumentsPath();
//         if (documentsPath == null) {
//           throw 'Could not access Documents folder';
//         }

//         final String filename =
//             'signed_${DateTime.now().millisecondsSinceEpoch}.pdf';
//         final String path = '$documentsPath${Platform.pathSeparator}$filename';
//         final File signedFile = File(path);
//         await signedFile.writeAsBytes(bytes);

//         setState(() {
//           _signedPdfPath = path;
//         });

//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('PDF signed successfully and saved to Documents'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         }
//       } catch (e) {
//         developer.log(
//           'Error during PDF signing',
//           error: e,
//           name: 'PdfSignScreen',
//         );
//         String errorMessage = 'Error signing PDF: $e';
//         if (e.toString().contains('Invalid pad')) {
//           errorMessage =
//               'Certificate error: Please make sure the certificate is in PKCS#12 format and the password is correct';
//         }
//         _showErrorSnackBar(errorMessage);
//       }
//     } finally {
//       document?.dispose();
//     }
//   }

//   Future<String?> _getDocumentsPath() async {
//     try {
//       if (Platform.isAndroid) {
//         // Request both storage and documents permissions on Android
//         final storageStatus = await Permission.storage.request();
//         final externalStorageStatus =
//             await Permission.manageExternalStorage.request();

//         if (!storageStatus.isGranted && !externalStorageStatus.isGranted) {
//           throw 'Storage permissions are required to save PDFs';
//         }

//         // Try to get the downloads directory first
//         final directory = await path_provider.getExternalStorageDirectory();
//         if (directory != null) {
//           // Create a 'DocPilot' folder in external storage
//           final docPilotDir = Directory('${directory.path}/DocPilot');
//           if (!await docPilotDir.exists()) {
//             await docPilotDir.create(recursive: true);
//           }
//           return docPilotDir.path;
//         }
//       } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
//         // For desktop platforms, use documents directory
//         final directory =
//             await path_provider.getApplicationDocumentsDirectory();
//         final docPilotDir =
//             Directory('${directory.path}${Platform.pathSeparator}DocPilot');
//         if (!await docPilotDir.exists()) {
//           await docPilotDir.create(recursive: true);
//         }
//         return docPilotDir.path;
//       }

//       // Fallback to application documents directory
//       final directory = await path_provider.getApplicationDocumentsDirectory();
//       final docPilotDir =
//           Directory('${directory.path}${Platform.pathSeparator}DocPilot');
//       if (!await docPilotDir.exists()) {
//         await docPilotDir.create(recursive: true);
//       }
//       return docPilotDir.path;
//     } catch (e) {
//       developer.log(
//         'Error getting documents directory',
//         error: e,
//         name: 'PdfSignScreen',
//       );
//       return null;
//     }
//   }

//   Future<void> _viewPdf(String? path) async {
//     if (path == null) return;

//     try {
//       if (Platform.isAndroid) {
//         final packageInfo = await PackageInfo.fromPlatform();
//         final uri = Uri.parse(
//             'content://${packageInfo.packageName}.fileprovider/external_files${path.substring(path.indexOf('/storage'))}');
//         if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//           _showErrorSnackBar('Could not open PDF file');
//         }
//       } else {
//         final uri = Uri.file(path);
//         if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//           _showErrorSnackBar('Could not open PDF file');
//         }
//       }
//     } catch (e) {
//       developer.log(
//         'Error opening PDF',
//         error: e,
//         name: 'PdfSignScreen',
//       );
//       _showErrorSnackBar('Error opening PDF: $e');
//     }
//   }

//   Widget _buildPrescriptionForm() {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Prescription Details',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _patientNameController,
//               decoration: const InputDecoration(
//                 labelText: 'Patient Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: _patientAgeController,
//               decoration: const InputDecoration(
//                 labelText: 'Patient Age',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: _doctorNameController,
//               decoration: const InputDecoration(
//                 labelText: 'Doctor Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: _diagnosisController,
//               decoration: const InputDecoration(
//                 labelText: 'Diagnosis',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 2,
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: _generatePrescriptionPdf,
//                 icon: const Icon(Icons.description),
//                 label: const Text('Generate Prescription PDF'),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 12,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('EMR Prescription'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildPrescriptionForm(),
//               const Divider(height: 32),
//               const Text(
//                 'Or select an existing PDF:',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton.icon(
//                 onPressed: _pickPdf,
//                 icon: const Icon(Icons.upload_file),
//                 label: const Text('Select PDF'),
//               ),
//               if (_selectedPdf != null) ...[
//                 const SizedBox(height: 20),
//                 Text(
//                   'Selected: ${_selectedPdf!.path}',
//                   style: const TextStyle(fontStyle: FontStyle.italic),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton.icon(
//                       onPressed: _signPdf,
//                       icon: const Icon(Icons.verified),
//                       label: const Text('Sign PDF'),
//                     ),
//                     const SizedBox(width: 20),
//                     ElevatedButton.icon(
//                       onPressed: () => _viewPdf(_selectedPdf?.path),
//                       icon: const Icon(Icons.visibility),
//                       label: const Text('View PDF'),
//                     ),
//                   ],
//                 ),
//               ],
//               if (_signedPdfPath != null) ...[
//                 const SizedBox(height: 20),
//                 Card(
//                   color: Colors.green.shade50,
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       children: [
//                         const Text(
//                           'Signed PDF saved successfully',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 8),
//                         Text('Location: $_signedPdfPath'),
//                         const SizedBox(height: 12),
//                         ElevatedButton.icon(
//                           onPressed: () => _viewPdf(_signedPdfPath),
//                           icon: const Icon(Icons.description),
//                           label: const Text('View Signed PDF'),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             foregroundColor: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
