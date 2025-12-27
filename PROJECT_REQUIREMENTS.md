# OBD-II Scan Application - Project Requirements

## Overview
An innovative OBDII Scan application for ELM327 devices, supporting Android and iOS platforms.

## Core Features

### 1. Payment System
- **Paid Application**: App must be a paid app (in-app purchase or one-time payment)
- Implementation: Google Play Billing (Android) + App Store In-App Purchase (iOS)

### 2. User Account Management
- User registration and login
- Password change functionality
- User profile management
- Secure authentication (JWT tokens or similar)

### 3. Credit System
- User balance/credit management
- Top-up functionality (in-app purchases)
- Credit usage tracking
- Transaction history

### 4. Vehicle Selection
- **Hierarchical Selection**: Brand → Model → Modification
- Purpose: Different car brands/models use different PIDs (Parameter IDs)
- Database structure for car information
- Support for manufacturer-specific PIDs

### 5. ELM327 Device Communication
- **Connection Methods**:
  - ✅ Bluetooth (flutter_blue_plus)
  - ✅ WiFi (wifi_iot)
  - ✅ USB (usb_serial)
- Device discovery and pairing
- Connection management
- Auto-reconnect functionality

### 6. OBD-II Data Reading
- **VIN Number**: Read Vehicle Identification Number from ECU
- **Mileage**: Display vehicle mileage
- **Standard PIDs**: Support standard OBD-II PIDs
- **Manufacturer-Specific PIDs**: 
  - Audi/VAG PIDs (for Audi e-tron testing)
  - Extensible system for other manufacturers
- Real-time data monitoring
- DTC (Diagnostic Trouble Codes) reading

### 7. PID Management
- Standard OBD-II PIDs (Mode 01, 03, 04, etc.)
- Manufacturer-specific PID database
- PID mapping per car brand/model/modification
- Dynamic PID discovery and testing
- PID response parsing and validation

## Technical Stack

### Flutter Dependencies (Already Added)
- `flutter_bloc: ^8.1.4` - State management
- `flutter_blue_plus: ^1.33.0` - Bluetooth connectivity
- `wifi_iot: ^0.3.19` - WiFi connectivity
- `usb_serial: ^0.5.2` - USB connectivity
- `http: ^1.2.0` - Backend API calls
- `shared_preferences: ^2.3.2` - Local storage

### Additional Dependencies Needed
- Authentication: `firebase_auth` or custom backend
- Payment: `in_app_purchase` (Flutter official)
- Database: `sqflite` or `hive` for local car database
- State persistence: `flutter_secure_storage` for tokens
- UI: Material Design 3 (already in Flutter)

## ELM327 Protocol

### Communication Protocol
- AT Commands for device initialization
- OBD-II Mode 01: Show current data
- OBD-II Mode 09: Read VIN (Service 09, PID 02)
- OBD-II Mode 03: Read DTCs
- Custom manufacturer modes for Audi/VAG

### VIN Reading
- Command: `09 02` (Mode 09, PID 02)
- Response parsing: Multi-frame response handling
- Validation: VIN format checking (17 characters)

### Mileage Reading
- Varies by manufacturer
- For Audi/VAG: Custom PID required
- Standard: May use Mode 01 with specific PIDs
- Requires testing with actual vehicle

## Project Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── errors/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── payment/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── credits/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── car_selection/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── obd_scan/
│   │   ├── data/
│   │   │   ├── services/
│   │   │   │   ├── elm327_service.dart
│   │   │   │   ├── bluetooth_service.dart
│   │   │   │   ├── wifi_service.dart
│   │   │   │   └── usb_service.dart
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── screens/
│   │       └── widgets/
│   └── dashboard/
│       └── presentation/
└── shared/
    ├── widgets/
    └── models/
```

## Implementation Phases

### Phase 1: Foundation
1. Project structure setup
2. Theme and UI foundation
3. Navigation setup
4. Core utilities

### Phase 2: Authentication & User Management
1. Login/Register screens
2. Password change functionality
3. User profile management
4. Secure token storage

### Phase 3: Payment & Credits
1. In-app purchase integration
2. Credit system backend
3. Top-up functionality
4. Balance display

### Phase 4: Car Selection
1. Car database structure
2. Brand/Model/Modification selection UI
3. PID mapping system
4. Car profile storage

### Phase 5: ELM327 Communication
1. Bluetooth connection
2. WiFi connection
3. USB connection
4. ELM327 protocol implementation
5. AT command handling

### Phase 6: OBD-II Data Reading
1. Standard PID reading
2. VIN reading implementation
3. Mileage reading (with testing)
4. Real-time data monitoring
5. DTC reading

### Phase 7: Manufacturer-Specific PIDs
1. Audi/VAG PID testing
2. PID database expansion
3. Dynamic PID discovery

### Phase 8: Polish & Testing
1. UI/UX refinement
2. Error handling
3. Performance optimization
4. Testing on real devices

## Future Enhancements (Phase 2)
- Apple CarPlay integration
- Android Auto integration
- Advanced diagnostics
- Data logging and export
- Cloud sync

## Testing Requirements
- Real ELM327 device (Bluetooth, WiFi, USB variants)
- Test vehicle: Audi e-tron (for PID discovery)
- Multiple Android devices
- Multiple iOS devices
- Various car brands/models for compatibility

## Notes
- PIDs for Audi e-tron need to be discovered through testing
- Manufacturer-specific PIDs are not publicly documented
- VIN reading works with standard OBD-II (Mode 09, PID 02)
- Mileage reading varies significantly by manufacturer
- CarPlay integration will be handled in a future phase

