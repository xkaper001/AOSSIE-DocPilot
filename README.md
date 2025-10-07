<!-- GSSoC banner and project insights -->
<h1 align="center">
  DocPilot
</h1>

<p align="center">
  <b>This project is now OFFICIALLY accepted for:</b>
</p>

<div align="center">
  <img src="assets/gssoc.png" alt="GSSOC" width="80%">
</div>

<table align="center">
    <thead align="center">
        <tr>
            <td><b>🌟 Stars</b></td>
            <td><b>🍴 Forks</b></td>
            <td><b>🐛 Issues</b></td>
            <td><b>🔔 Open PRs</b></td>
            <td><b>🔕 Closed PRs</b></td>
            <td><b>🛠️ Languages</b></td>
            <td><b>👥 Contributors</b></td>
        </tr>
     </thead>
    <tbody>
         <tr>
            <td><img alt="Stars" src="https://img.shields.io/github/stars/xkaper001/DocPilot?style=flat&logo=github"/></td>
            <td><img alt="Forks" src="https://img.shields.io/github/forks/xkaper001/DocPilot?style=flat&logo=github"/></td>
            <td><img alt="Issues" src="https://img.shields.io/github/issues/xkaper001/DocPilot?style=flat&logo=github"/></td>
            <td><img alt="Open PRs" src="https://img.shields.io/github/issues-pr/xkaper001/DocPilot?style=flat&logo=github"/></td>
            <td><img alt="Closed PRs" src="https://img.shields.io/github/issues-pr-closed/xkaper001/DocPilot?style=flat&color=critical&logo=github"/></td>
            <td><img alt="Languages Count" src="https://img.shields.io/github/languages/count/xkaper001/DocPilot?style=flat&color=green&logo=github"></td>
            <td><img alt="Contributors Count" src="https://img.shields.io/github/contributors/xkaper001/DocPilot?style=flat&color=blue&logo=github"/></td>
        </tr>
    </tbody>
</table>

<div align="center">
<h1> 🩺 DocPilot - A Next Gen EMR App </h1>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](CONTRIBUTING.md)

</div>

![](docs/assets/docpilot_preview.gif)

**DocPilot** revolutionizes healthcare by transforming traditional Electronic Medical Record (EMR) systems through the power of AI. Our intelligent platform eliminates manual data entry by converting doctor-patient conversations into structured prescriptions, making healthcare delivery faster, more accurate, and incredibly efficient.

## ✨ What Makes DocPilot Special?

🗣️ **Voice-to-Prescription**: Convert consultation recordings directly into structured prescriptions  
🤖 **AI-Powered**: Advanced medical transcription and data extraction  
📅 **Integrated Scheduling**: Seamless appointment management system  
🔒 **Secure & Compliant**: Digital signatures with PFX certificates  
📱 **Cross-Platform**: Available on mobile and desktop  

## 💻 Tech Stack

- 🎯 **Frontend**: Flutter & Dart
- 🗄️ **Backend**: Appwrite
- 🤖 **AI**: Google Gemini API + Deepgram's medical transcription
- 📄 **Documents**: Syncfusion PDF generation

##  📱 App Preview

<div align="center">
  
| Dashboard | Calendar | Manage Patient |
| :---         |     :---      |          :--- |
| <img src= "https://github.com/user-attachments/assets/4f461c03-692a-4657-9deb-099e6c7e8395" width="250" height="auto" />  | <img src="https://github.com/user-attachments/assets/1bfcd307-dc0b-4b13-a90e-70447a61e016" width="250" height="auto" />    | <img src="https://github.com/user-attachments/assets/7f97d944-0976-47fd-8a30-480ced123a1c" width="250" height="auto" />    |

| Patients | Prescribe | Generated Prescription |
| :---         |     :---      |          :--- |
|  <img src="https://github.com/user-attachments/assets/e173dc6d-cdbe-4754-8002-d6fb81747c85" width="250" height="auto" /> | <img src="https://github.com/user-attachments/assets/0483d5bf-65f0-407f-9570-e86df91a7776" width="250" height="auto" />   |  <img src="https://github.com/user-attachments/assets/0bbf2b0e-a809-41c3-a542-749a656a5a99" width="250" height="auto"/>    |

| Login Screen (Doctor) | Confirmation Code Screen | Login Screen (Patient) |
| :---         |     :---      |          :--- |
|  <img src="https://github.com/user-attachments/assets/c96e7a74-916e-4663-8b44-f809461d4e15" width="250" height="auto" /> | <img src="https://github.com/user-attachments/assets/0bbf2b0e-a809-41c3-a542-749a656a5a99" width="250" height="auto" />   |  <img src="https://github.com/user-attachments/assets/26b93a0d-e17d-4a0c-98cd-190f6279da76" width="250" height="auto"/>    |
</div>

## 🎨 Design Prototype
Check out our app's interface on Figma: [Figma Design Link](https://www.figma.com/design/pD32RZaskUitWMr7nv8nfy/DocPilot?node-id=0-1&t=YoRZ8aAP355lRChq-1)

## 🚀 Quick Start

### 📋 Prerequisites
- Flutter SDK installed
- Dart SDK (comes with Flutter)
- Android Studio or Xcode for mobile development

### 🛠️ Setup & Installation
```bash
# Clone the repository
git clone https://github.com/xkaper001/DocPilot.git
cd DocPilot

# Install dependencies
flutter pub get

# Generate required files
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

For detailed setup instructions, see our [Setup Guide](./docs/SETUP.md).

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [Setup Guide](./docs/SETUP.md) | Complete installation and setup instructions |
| [Technical Overview](./TECHNICAL_OVERVIEW.md) | Detailed technical architecture and workflow |
| [Folder Structure](./docs/FOLDER_STRUCTURE.md) | Project organization and structure |
| [Contributing](./CONTRIBUTING.md) | How to contribute to DocPilot |
| [Code of Conduct](./CODE_OF_CONDUCT.md) | Community guidelines and standards |

## 🌟 Key Features

### 🗣️ Conversational Prescription Generation
- Convert voice recordings to structured prescriptions
- Medical-grade transcription accuracy
- AI-powered data extraction

### 📄 Automated Document Workflow
- Seamless audio upload and processing
- Real-time prescription generation
- Editable output for doctor review

### 📅 OPD Appointment Management
- Integrated calendar system
- Real-time scheduling
- Patient booking capabilities

### 🎨 User Experience
- Clean, responsive Flutter UI
- Cross-platform compatibility
- Accessibility-focused design

### 🖋️ Secure PDF Generation
- Digital signature support
- PFX certificate integration
- Biometric verification

## 🤝 Contributing

We welcome contributions from the community! Whether you're a developer, designer, or healthcare professional, there are many ways to help improve DocPilot.

- 🐛 [Report Issues](https://github.com/xkaper001/DocPilot/issues)
- 💡 [Request Features](https://github.com/xkaper001/DocPilot/issues)
- 🔧 [Submit Pull Requests](https://github.com/xkaper001/DocPilot/pulls)
- 📖 [Improve Documentation](./CONTRIBUTING.md)

Please read our [Contributing Guidelines](./CONTRIBUTING.md) and [Code of Conduct](./CODE_OF_CONDUCT.md) before getting started.

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Healthcare Professionals** for valuable insights and feedback
- **Open Source Community** for amazing tools and libraries
- **Contributors** who help make DocPilot better every day

## 📞 Support

- 💬 [GitHub Discussions](https://github.com/xkaper001/DocPilot/discussions)
- 🐛 [Report Issues](https://github.com/xkaper001/DocPilot/issues)
- 📧 Contact maintainers for sensitive matters

---

<div align="center">

**Made with ❤️ for better healthcare**

[⭐ Star us on GitHub](https://github.com/xkaper001/DocPilot) • [🍴 Fork the project](https://github.com/xkaper001/DocPilot/fork) • [📖 Read the docs](./docs/)

</div>
