# KP Drug Interaction Feature

![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)
![iOS](https://img.shields.io/badge/iOS-16.0-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Motivation](#motivation)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Disclaimer](#disclaimer)

## Overview

The **KP Drug Interaction Feature** is a proof of concept (POC) developed to integrate the National Institutes of Health (NIH) National Library of Medicine (NLM) Drug Interaction API into Kaiser Permanente's (KP) flagship iOS application. This feature is designed to enhance patient safety by providing comprehensive insights into potential multi-drug interactions, empowering KP members with vital health information directly within the KP mobile app.

> **Note:** The NIH NLM Drug Interaction API used in this project is currently deprecated. Future integrations should consider alternative APIs or updated endpoints.

## Key Features

- **Comprehensive Drug Interaction Insights:** Provides detailed information on potential interactions between multiple medications, aiding in the mitigation of polypharmacy risks.
  
- **User-Friendly Interface:** Seamlessly integrates into the existing KP iOS application, ensuring a consistent and intuitive user experience.
  
- **Real-Time Data Retrieval:** Leverages the NIH NLM Drug Interaction API to fetch and display up-to-date information on drug interactions.
  
- **Adherence to KP Standards:** Developed following Kaiser Permanente's design and coding standards to ensure maintainability and scalability.

## Motivation

In the realm of healthcare, understanding drug interactions is paramount for ensuring patient safety, especially for individuals managing multiple medications. By embedding this feature into the KP flagship application, we strive to:

- **Enhance Patient Safety:** Minimize the risk of adverse drug interactions through timely and accurate information dissemination.
  
- **Empower Users:** Equip KP members with the necessary tools to make informed decisions regarding their medication regimens.
  
- **Support Healthcare Providers:** Provide healthcare professionals with reliable interaction data to assist in patient consultations and treatment planning.

## Architecture

The KP Drug Interaction Feature is built using SwiftUI for the user interface and leverages Xcode for development. The feature communicates with the NIH NLM Drug Interaction API to fetch interaction data, processes the information, and presents it within the KP iOS application.

### Components

- **UI Layer:** SwiftUI views adhering to KP's design guidelines.
- **Networking Layer:** Handles API requests and responses using `URLSession` and `Combine`.
- **Data Layer:** Models and manages drug interaction data.
- **Error Handling:** Robust mechanisms to manage API failures and data inconsistencies.
- **Persistence Layer:** (If applicable) Caches interaction data for offline access using Core Data or similar solutions.

## Tech Stack

- **Language:** Swift 5.7
- **Frameworks:** SwiftUI
- **Development Environment:** Xcode 14+
- **API:** NIH NLM Drug Interaction API (Deprecated)
- **Version Control:** Git, GitHub
- **CI/CD:** GitHub Actions
- **Testing:** XCTest for unit and UI testing

## Installation

To run this project locally, follow the steps below:

### Prerequisites

- **Xcode 14+** installed on your Mac.
- **Git** installed on your machine.
- **Access Credentials:** NIH NLM Drug Interaction API requires authentication, ensure you have the necessary API keys or tokens.

### Steps

1. **Clone the Repository**

```bash
git clone https://github.com/iamrishabruh/drug_interaction_checker.git
cd drug_interaction_checker
```

2. **Open the Project in Xcode**

```bash
Navigate to the cloned directory.
Open `KPDrugInteractionFeature.xcodeproj` with Xcode.
```

3. **Configure API Access**

> **Important:** Since the NIH NLM Drug Interaction API is deprecated, ensure you have access to an alternative API or have the necessary credentials if available.

```bash
Locate the Networking layer files (e.g., `APIService.swift`).
Update the API endpoint URLs and insert your API keys or tokens as required.
```

4. **Install Dependencies**

```bash
If the project uses Swift Package Manager or CocoaPods, ensure dependencies are installed.
```

- **Swift Package Manager:**

```bash
Xcode typically handles this automatically. If not, go to `File > Swift Packages > Resolve Package Versions`.
```

- **CocoaPods:**

```bash
  Run "pod install" in the project directory.
```

5. **Build and Run the Application**

```bash
Select the desired simulator or connect your iOS device.
Click the Run button (▶️) in Xcode to build and launch the application.
```

## Usage

Once the application is running:

1. **Navigate to Drug Interaction Feature**

- From the main dashboard, select the "Drug Interaction" section.

2. **Input Medications**

- Enter the names of the medications you are currently taking. You can add multiple medications to check for interactions.

3. **View Interaction Report**

- After submitting, the application will display a comprehensive report detailing potential interactions, including severity levels and recommended actions.

## Testing

### Unit Tests

The project includes unit tests to ensure the reliability of the networking layer and data processing.

- **Run Tests:**
- In Xcode, select `Product > Test` or press `⌘U`.

### UI Tests

UI tests are implemented using XCTest to verify the user interface components and interactions.

- **Run UI Tests:**
- In Xcode, select `Product > Test` or press `⌘U`.

### Test Coverage

- Ensure all critical components have adequate test coverage.
- Add more tests as new features are implemented.

## Contributing

We welcome contributions to enhance the KP Drug Interaction Feature. To contribute:

1. **Fork the Repository**

```bash
Click the Fork button at the top-right corner of this repository.
```

2. **Create a Feature Branch**

```bash
git checkout -b feature/YourFeatureName
```

3. **Commit Your Changes**

```bash
git commit -m "Add Your Feature Description"
```

4. **Push to the Branch**

```bash
git push origin feature/YourFeatureName
```

5. **Open a Pull Request**

```bash
Navigate to the original repository and open a pull request detailing your changes.
```

### Contribution Guidelines

- Adhere to Kaiser Permanente's coding standards and best practices.

- Ensure all new features and changes are well-documented.

- Include relevant tests for your contributions.

- Link any related issues in your pull request description.

## License

This project is licensed under the MIT License.

## Contact

For questions, suggestions, or feedback, please reach out to:

- [Email](mailto:rchouhan.network@gmail.com)
- [Linkedin](https://www.linkedin.com/in/chouhanrishabh/)

## Disclaimer

This is a proof of concept project and not intended for production use. The NIH NLM Drug Interaction API is deprecated; please refer to official sources for the latest information on drug interactions.
