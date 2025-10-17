// class PrescriptionRepositoryImpl implements PrescriptionRepository {
//   final AppwriteService appwriteService;
//   final AIService aiService;

//   PrescriptionRepositoryImpl(this.appwriteService, this.aiService);

//   @override
//   Future<Prescription> extractMedicalData(AudioData audio) async {
//     final text = await aiService.transcribeAudio(audio);
//     final extractedData = await aiService.extractMedicalInformation(text);
//     return Prescription.fromExtractedData(extractedData);
//   }
// }
