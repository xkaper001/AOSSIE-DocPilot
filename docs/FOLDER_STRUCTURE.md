# Folder Structure

```
📂 docpilot/
 ├── 📂 lib/                          # Main application code
 │    ├── 📂 core/                    # Common utilities, themes, constants
 │    │    ├── app_colors.dart        # Theme colors
 │    │    ├── app_styles.dart        # Common text styles
 │    │    ├── app_routes.dart        # Route names (for go_router)
 │    │    ├── error_handler.dart     # Global error handling
 │    │    ├── logger.dart            # Logging service
 │    │    ├── service_locator.dart   # Dependency Injection (GetIt)
 │    │
 │    ├── 📂 presentation/            # UI layer (Screens & Widgets)
 │    │    ├── 📂 blocs/              # State Management (BLoC)
 │    │    │    ├── auth_bloc.dart    # Authentication BLoC
 │    │    │    ├── doctor_bloc.dart  # Doctor Dashboard BLoC
 │    │    │    ├── patient_bloc.dart # Patient Dashboard BLoC
 │    │    │    ├── prescription_bloc.dart # Prescription BLoC
 │    │    │
 │    │    ├── 📂 screens/            # App Screens
 │    │    │    ├── login_screen.dart
 │    │    │    ├── signup_screen.dart
 │    │    │    ├── doctor_dashboard.dart
 │    │    │    ├── patient_dashboard.dart
 │    │    │    ├── opd_appointments.dart
 │    │    │    ├── prescription_view.dart
 │    │    │    ├── settings_screen.dart
 │    │    │
 │    │    ├── 📂 widgets/            # Reusable UI Components
 │    │    │    ├── custom_button.dart
 │    │    │    ├── patient_card.dart
 │    │    │    ├── prescription_card.dart
 │    │    │    ├── voice_recorder_widget.dart
 │    │    │    ├── appointment_list_item.dart
 │    │
 │    ├── 📂 domain/                   # Business Logic Layer
 │    │    ├── 📂 entities/            # Core Business Models
 │    │    │    ├── prescription.dart
 │    │    │    ├── patient.dart
 │    │    │    ├── doctor.dart
 │    │    │    ├── opd_appointment.dart
 │    │    │
 │    │    ├── 📂 repositories/        # Abstract Repositories
 │    │    │    ├── auth_repository.dart
 │    │    │    ├── prescription_repository.dart
 │    │    │    ├── appointment_repository.dart
 │    │    │
 │    │    ├── 📂 use_cases/           # Business Rules & Interactors
 │    │    │    ├── login_use_case.dart
 │    │    │    ├── fetch_patients_use_case.dart
 │    │    │    ├── generate_prescription_use_case.dart
 │    │    │    ├── manage_appointments_use_case.dart
 │    │
 │    ├── 📂 data/                     # Data Layer
 │    │    ├── 📂 models/              # Data Models (DTOs)
 │    │    │    ├── prescription_dto.dart
 │    │    │    ├── patient_dto.dart
 │    │    │    ├── doctor_dto.dart
 │    │    │    ├── opd_appointment_dto.dart
 │    │    │
 │    │    ├── 📂 sources/             # Data Sources (API, Local DB)
 │    │    │    ├── appwrite_service.dart   # Appwrite API Interactions
 │    │    │    ├── ai_transcription_service.dart # AI Voice-to-Text Processing
 │    │    │    ├── local_storage.dart   # Local storage (Hive, SharedPreferences)
 │    │    │
 │    │    ├── 📂 repositories/         # Implementation of Domain Repositories
 │    │    │    ├── auth_repository_impl.dart
 │    │    │    ├── prescription_repository_impl.dart
 │    │    │    ├── appointment_repository_impl.dart
 │    │
 │    ├── 📂 config/                     # App Configurations
 │    │    ├── app_config.dart           # Environment-based Configuration
 │    ├── 📂 utils/                      # Helper functions & formatters
 │    │    ├── date_formatter.dart
 │    │    ├── validators.dart
 │    │    ├── speech_to_text_helper.dart
 │    │
 │    ├── main.dart                      # App Entry Point
 │
 ├── 📂 test/                            # Unit & Widget Tests
 │
 ├── 📜 pubspec.yaml                     # Dependencies & Package Config
 ├── 📜 README.md                        # Project Documentation
```