# Technical Overview 🔧

This document provides an in-depth technical overview of DocPilot's architecture, workflow, and implementation details.

## 🏗️ Architecture Overview

DocPilot follows Clean Architecture principles with a clear separation of concerns:

### 📂 Project Structure
For detailed folder structure, see [Folder Structure](./docs/FOLDER_STRUCTURE.md)

### 🎯 Technology Stack

- **Frontend**: Flutter & Dart
- **Backend**: Appwrite (BaaS)
- **AI Transcription**: Deepgram's `nova-3-medical` model API (leading in medical transcription, speech-to-text)
- **AI Processing**: Google Gemini API (gen-ai)
- **PDF Generation**: `syncfusion_flutter_pdf`
- **Calendar Integration**: `syncfusion_flutter_calendar`
- **State Management**: BLoC pattern
- **Dependency Injection**: GetIt

## ❓ How DocPilot Solves EMR Problems

DocPilot addresses the challenges of legacy EMR systems by radically simplifying the process for medical professionals:

### 1️⃣ Conversational AI Integration 🗣️🤖

By capturing the entire consultation audio, DocPilot utilizes cutting-edge speech-to-text and language model APIs to reliably transcribe and extract critical medical data in real time. This removes the need for manual data entry and minimizes errors.

### 2️⃣ Streamlined Workflow ⚡

Instead of navigating multiple disparate systems, doctors access a single application that automatically generates structured prescriptions from their conversations. This leads to:

- 📝 **Reduced Administrative Burden**: No more time wasted on manual transcription and record keeping.
- ✅ **Improved Accuracy**: Automatic extraction and prompt correction capabilities ensure critical medical details are correctly recorded.
- ⏱️ **Faster Patient Turnaround**: With a digital-first approach, prescriptions can be reviewed, signed, and shared almost instantaneously.

### 3️⃣ Integrated OPD Appointment Management 📅

Incorporating scheduling capabilities via a calendar module lets doctors manage consultations and follow-ups from within the same ecosystem. This end-to-end integration increases efficiency and ensures continuity of care.

### 4️⃣ Secure and Compliant Data Handling 🔒

With robust authentication, digital PDF signing (using individual PFX certificates), and secure storage practices, DocPilot is built to meet data security standards and instill trust among its users.

## 🌟 Key Features & Technical Implementation

### 🗣️ Conversational Prescription Generation

**Technology**: Deepgram API + Google GenAI

**Implementation**:
- Uses Deepgram's medical transcription API to convert recorded consultations into text with high accuracy in medical terminology
- Leverages Google GenAI (gemini-pro) to parse the transcription and generate a structured JSON prescription
- Output includes: symptoms, diagnosis, medications (with dosage and frequency), tests, and follow-up instructions

**Technical Flow**:
```
Audio Recording → Deepgram API → Text Transcription → Google GenAI → Structured JSON → UI Rendering
```

### 📄 Automated Document Workflow

**Technology**: Appwrite + Custom Functions

**Implementation**:
- **Upload**: Doctor's audio consultation is uploaded and stored securely using Appwrite's storage
- **Processing**: An Appwrite function orchestrates the transcription and AI extraction steps
- **Output**: The structured output is rendered as an editable prescription on the doctor's dashboard

**Technical Components**:
- Appwrite Storage for audio files
- Appwrite Functions for serverless processing
- REST API integration for external AI services

### 📅 OPD Appointment Management

**Technology**: `syncfusion_flutter_calendar`

**Implementation**:
- Real-time scheduling with calendar visualization
- Appointment display on doctor's dashboard
- Patient booking capabilities
- Integration with notification systems

**Features**:
- Multiple view modes (day, week, month)
- Appointment conflict detection
- Reminder notifications
- Recurring appointment support

### 🎨 User Experience & Interface

**Technology**: Flutter + BLoC + GetIt

**Architecture Pattern**: Clean Architecture

**Implementation Details**:
- **Presentation Layer**: Flutter widgets with BLoC state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: Repository pattern with data sources
- **Dependency Injection**: GetIt for service locator pattern

**UI/UX Features**:
- Responsive design for multiple screen sizes
- Dark/light theme support
- Accessibility compliance
- Smooth animations and transitions

### 🖋️ Secure PDF Generation & Signing

**Technology**: `syncfusion_flutter_pdf` + PFX Certificates

**Security Features**:
- PDF prescription generation with custom templates
- Digital signing mechanism using individual PFX certificates per doctor
- Biometric verification on client side
- Certificate-based authentication
- Tamper-proof document integrity

**Implementation**:
```dart
// PDF Generation Flow
PdfDocument → Add Content → Apply Digital Signature → Save Signed PDF
```

## 🔄 Complete Workflow Overview

### Step 1: 🎤 Audio Upload & URL Retrieval
The doctor initiates the process by recording and uploading the consultation audio, which is stored on Appwrite and generates a publicly accessible URL.

**Technical Implementation**:
- Audio recording using device microphone
- Upload to Appwrite storage bucket
- Generation of secure, time-limited URL
- Storage of metadata in database

### Step 2: 🗣️ Transcription via Deepgram
An Appwrite function calls Deepgram's nova-3-medical model to convert audio into text, ensuring high accuracy in medical terminology.

**Technical Implementation**:
```javascript
// Appwrite Function Example
const transcription = await deepgram.transcribe({
  url: audioUrl,
  model: 'nova-3-medical',
  punctuate: true,
  diarize: true
});
```

### Step 3: 🤖 Extraction with Google GenAI
The transcription is then sent to Google GenAI with a prompt that instructs the model to extract relevant medical data and output a structured JSON.

**Technical Implementation**:
```javascript
// AI Processing Example
const prompt = `Extract medical information from this consultation:
${transcription}

Return structured JSON with: symptoms, diagnosis, medications, tests, follow-up`;

const structuredData = await gemini.generateContent(prompt);
```

### Step 4: 📝 Prescription Review & PDF Generation
The app parses the JSON, allowing the doctor to review the prescription. Once approved, the prescription is converted into a PDF and digitally signed with the doctor's PFX certificate.

**Technical Implementation**:
- JSON parsing and validation
- UI rendering for doctor review
- PDF template application
- Digital signature application
- Certificate verification

### Step 5: 📅 OPD Scheduling Integration
Patients and doctors manage and schedule appointments seamlessly through an integrated calendar view.

**Technical Implementation**:
- Calendar data synchronization
- Real-time updates via websockets
- Notification scheduling
- Integration with external calendar systems

## 🔒 Security & Privacy Considerations

### Data Protection
- End-to-end encryption for sensitive data
- HIPAA compliance considerations
- Secure storage practices
- Access control and audit logging

### Authentication & Authorization
- Multi-factor authentication
- Role-based access control (RBAC)
- Session management
- Biometric authentication support

### Compliance
- GDPR compliance for data handling
- Medical data privacy regulations
- Audit trail maintenance
- Data retention policies

## 🚀 Performance Optimizations

### Mobile Performance
- Lazy loading of screens and data
- Image optimization and caching
- Efficient state management
- Background processing for AI operations

### Scalability
- Serverless architecture with Appwrite
- Horizontal scaling capabilities
- Caching strategies
- Database optimization

## 🧪 Testing Strategy

### Test Coverage
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for complete workflows
- End-to-end testing for critical paths

### Testing Tools
- Flutter test framework
- Mockito for mocking dependencies
- Golden tests for UI consistency
- Performance testing tools

## 📊 Monitoring & Analytics

### Performance Monitoring
- App performance metrics
- Crash reporting and analysis
- User session tracking
- API response time monitoring

### Business Intelligence
- Usage analytics
- Feature adoption metrics
- Error rate tracking
- User feedback collection

---

This technical overview provides the foundation for understanding DocPilot's implementation. For setup instructions, see [Setup Guide](./docs/SETUP.md), and for contribution guidelines, see [Contributing](./CONTRIBUTING.md).