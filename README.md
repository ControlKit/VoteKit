# VoteKit <img src='https://github.com/maziar/ReadmeFiles/blob/main/streamline-flex_politics-vote-2.svg' width='30'/>

A powerful and customizable iOS voting component built with Swift that provides an elegant way to collect user feedback and votes in your iOS applications.

## 🚀 Features

- **Multiple Presentation Styles**: Choose from 5 different UI styles (Fullscreen, Popover variants)
- **Highly Customizable**: Extensive theming options for colors, fonts, layouts, and animations
- **Localization Support**: Built-in multi-language support with `CKLanguage`
- **Async/Await Ready**: Modern Swift concurrency support
- **Network Integration**: Built-in API integration for vote submission
- **Smart Caching**: Prevents duplicate vote prompts using UserDefaults
- **Responsive Design**: Adapts to different screen sizes and orientations
- **Alert System**: Customizable success/error alerts with animations

## 📱 Screenshots

*Coming soon - Add screenshots of different styles*

## 🏗️ Architecture

VoteKit follows a clean MVVM architecture with the following key components:

### Core Components

- **VoteKit**: Main entry point and coordinator
- **VoteViewController**: Handles presentation and user interactions
- **VoteViewModel**: Business logic and data management
- **VoteViewConfig**: Comprehensive styling and configuration
- **VoteViewStyle**: Multiple UI presentation styles

### Key Protocols

- **Votable**: Core voting functionality
- **VoteActionable**: Action handling
- **VoteSavable**: Data persistence
- **VoteDelegate**: UI interaction callbacks

## 📦 Installation

### Swift Package Manager

Add VoteKit to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/VoteKit.git", from: "1.0.0")
]
```

### CocoaPods

Add VoteKit to your `Podfile`:

```ruby
pod 'VoteKit'
```

Then run:

```bash
pod install
```

## 🎯 Quick Start

### Simple Usage (2 Lines of Code)

Get started with VoteKit in just 2 lines:

```swift
let voteKit = VoteKit()
await voteKit.configure(root: self, config: VoteServiceConfig(
    appId: "your-app-id",
    name: "feature-feedback",
    language: .english
))
```

That's it! VoteKit will automatically:
- Fetch vote data from your server
- Present the appropriate UI style
- Handle user interactions
- Submit votes
- Show success/error feedback
- Dismiss when complete

### Basic Implementation

```swift
import VoteKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVoteKit()
    }
    
    private func setupVoteKit() {
        Task {
            let voteKit = VoteKit()
            await voteKit.configure(
                root: self,
                config: VoteServiceConfig(
                    appId: "com.yourapp.vote",
                    name: "user-satisfaction",
                    language: .english
                )
            )
        }
    }
}
```

## 🎨 Advanced Usage

### Custom Styling

VoteKit offers extensive customization options:

```swift
// Create custom configuration
let customConfig = VoteServiceConfig(
    style: .popover1,
    appId: "your-app-id",
    name: "custom-vote",
    language: .english
)

// Customize appearance
customConfig.viewConfig.title = "Rate Our App"
customConfig.viewConfig.question = "How would you rate your experience?"
customConfig.viewConfig.buttonBackColor = .systemBlue
customConfig.viewConfig.popupViewCornerRadius = 20
customConfig.viewConfig.titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)

// Apply custom colors
customConfig.viewConfig.popupViewBackColor = UIColor.systemBackground
customConfig.viewConfig.questionViewBackColor = UIColor.secondarySystemBackground
customConfig.viewConfig.buttonTitleColor = .white

// Customize alerts
customConfig.viewConfig.successMessage = "Thank you for your feedback!"
customConfig.viewConfig.errorMessage = "Oops! Something went wrong. Please try again."
customConfig.viewConfig.alertSuccessIconColor = .systemGreen
customConfig.viewConfig.alertErrorIconColor = .systemRed

// Present with custom configuration
let voteKit = VoteKit()
await voteKit.configure(
    root: self,
    modalPresentationStyle: .overCurrentContext,
    config: customConfig
)
```

### Multiple Presentation Styles

Choose from 5 different presentation styles:

```swift
// Fullscreen style
let fullscreenConfig = VoteServiceConfig(
    style: .fullscreen1,
    appId: "app-id",
    name: "fullscreen-vote",
    language: .english
)

// Popover styles
let popoverConfigs = [
    VoteServiceConfig(style: .popover1, appId: "app-id", name: "popover1", language: .english),
    VoteServiceConfig(style: .popover2, appId: "app-id", name: "popover2", language: .english),
    VoteServiceConfig(style: .popover3, appId: "app-id", name: "popover3", language: .english),
    VoteServiceConfig(style: .popover4, appId: "app-id", name: "popover4", language: .english)
]
```

### Custom Service Integration

For advanced use cases, you can provide your own service implementation:

```swift
class CustomVoteService: GenericServiceProtocol {
    // Implement your custom service logic
}

let voteKit = VoteKit(voteService: CustomVoteService())
```

### Localization Support

VoteKit supports multiple languages:

```swift
let config = VoteServiceConfig(
    appId: "app-id",
    name: "localized-vote",
    language: .persian // or .english, .arabic, etc.
)
```

## 🔧 Configuration Options

### VoteServiceConfig Properties

| Property | Type | Description |
|----------|------|-------------|
| `appId` | String | Your application identifier |
| `name` | String | Vote campaign name |
| `language` | CKLanguage | Language for localization |
| `style` | VoteViewStyle | UI presentation style |
| `sdkVersion` | String | SDK version (auto-set) |

### VoteViewConfig Styling Options

#### Layout & Appearance
- `style`: Presentation style (.fullscreen1, .popover1-4)
- `popupViewBackColor`: Background color
- `popupViewCornerRadius`: Corner radius
- `contentViewBackColor`: Overlay background
- `contentViewAlpha`: Overlay transparency

#### Typography
- `titleFont`: Title font
- `title`: Title text
- `titleColor`: Title color
- `questionFont`: Question font
- `question`: Question text
- `questionColor`: Question color
- `voteItemFont`: Vote option font
- `voteItemColor`: Vote option color

#### Buttons
- `buttonFont`: Submit button font
- `buttonNormalTitle`: Submit button text
- `buttonBackColor`: Submit button background
- `buttonTitleColor`: Submit button text color
- `buttonCornerRadius`: Submit button corner radius
- `closeButtonFont`: Close button font
- `closeButtonNormalTitle`: Close button text
- `closeButtonBackColor`: Close button background
- `closeButtonTitleColor`: Close button text color

#### Alert System
- `successMessage`: Success alert message
- `errorMessage`: Error alert message
- `alertContainerBackgroundColor`: Alert background
- `alertContainerCornerRadius`: Alert corner radius
- `alertSuccessIconColor`: Success icon color
- `alertErrorIconColor`: Error icon color
- `alertFadeAnimationDuration`: Fade animation duration
- `alertScaleAnimationDuration`: Scale animation duration

## 🌐 API Integration

VoteKit automatically handles:

1. **Vote Data Fetching**: Retrieves vote campaigns from your server
2. **Vote Submission**: Submits user selections
3. **Duplicate Prevention**: Uses UserDefaults to prevent showing the same vote multiple times
4. **Error Handling**: Graceful error handling with user-friendly messages

### API Endpoints

VoteKit expects your backend to provide:

- **GET** `/vote`: Fetch vote campaign data
- **POST** `/vote/{id}/submit`: Submit vote selection

### Request/Response Format

```swift
// Vote Request
struct VoteRequest {
    let appId: String
    let name: String
    let sdkVersion: String
    let applicationVersion: String
    let deviceUUID: String
}

// Vote Response
struct VoteResponse {
    let data: VoteModel?
}

struct VoteModel {
    let id: String
    let name: String
    let force: Bool
    let title: LocalString?
    let description: LocalString?
    let accept_button_title: LocalString?
    let cancel_button_title: LocalString?
    let vote_options: [VoteOption]
    let sdk_version: String?
    let created_at: String?
}
```

## 🎯 Use Cases

### Simple Feedback Collection
```swift
// Quick user satisfaction survey
let voteKit = VoteKit()
await voteKit.configure(root: self, config: VoteServiceConfig(
    appId: "com.app.feedback",
    name: "satisfaction-survey",
    language: .english
))
```

### Feature Rating
```swift
// Rate new features
let config = VoteServiceConfig(
    style: .popover1,
    appId: "com.app.features",
    name: "feature-rating",
    language: .english
)
config.viewConfig.title = "Rate This Feature"
config.viewConfig.question = "How useful is this new feature?"
```

### A/B Testing
```swift
// Different styles for A/B testing
let styleA = VoteServiceConfig(style: .fullscreen1, appId: "app", name: "test-a", language: .english)
let styleB = VoteServiceConfig(style: .popover1, appId: "app", name: "test-b", language: .english)
```

## 🔒 Privacy & Security

- **No Personal Data**: VoteKit only collects vote selections, not personal information
- **Device UUID**: Uses anonymous device identifiers for duplicate prevention
- **Secure Communication**: All API calls use HTTPS
- **Local Storage**: Minimal local storage for vote state management

## 🛠️ Requirements

- iOS 13.0+
- Swift 5.0+
- Xcode 12.0+

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/yourusername/VoteKit/issues) page
2. Create a new issue with detailed information
3. Contact: [your-email@example.com]

## 🚀 Roadmap

- [ ] Additional UI styles
- [ ] Custom animations
- [ ] Analytics integration
- [ ] Offline support
- [ ] Custom vote types (rating scales, multiple choice, etc.)

---

Made with ❤️ for the iOS community
