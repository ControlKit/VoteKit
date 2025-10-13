//
//  File.swift
//  
//
//  Created by Maziar Saadatfar on 10/18/23.
//

import Foundation
import UIKit
import ControlKitBase
public class VoteViewConfig {
    public init(lang: CKLanguage) {
        self.lang = lang
    }
    public let lang: CKLanguage
    public var style: VoteViewStyle = .fullscreen1
    
    public var contentViewBackColor: UIColor = UIColor(r: 0, g: 0, b: 0, a: 0.8)
    public var popupViewBackColor: UIColor = .white
    public var popupViewCornerRadius: CGFloat = 15.0
    
    public var questionViewBackColor: UIColor = UIColor(r: 245, g: 245, b: 245)
    public var questionViewCornerRadius: CGFloat = 20.0
    
    public var titleFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
    public var title = "It's a Vote"
    public var titleColor: UIColor = .black
    
    public var questionFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    public var question = "It's a Question?"
    public var questionColor: UIColor = .black
    
    public var voteItemFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    public var voteItemColor: UIColor = .black
    
    public var buttonFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    public var buttonNormalTitle: String = "Ok"
    public var buttonBackColor: UIColor = UIColor(r: 253, g: 105, b: 42)
    public var buttonTitleColor: UIColor = .white
    public var buttonCornerRadius: CGFloat = 20.0
    public var buttonBorderWidth: CGFloat = 0.0
    public var buttonBorderColor: UIColor = .clear
    
    public var closeButtonFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    public var closeButtonNormalTitle: String = "Close"
    public var closeButtonBackColor: UIColor = .clear
    public var closeButtonTitleColor: UIColor = .orange
    public var closeButtonCornerRadius: CGFloat = 20.0
    public var closeButtonBorderWidth: CGFloat = 0.0
    public var closeButtonBorderColor: UIColor = UIColor(r: 253, g: 105, b: 42)
    public var closeButtonImage: UIImage?
    public var closeButtonImageColor: UIColor = UIColor(r: 253, g: 105, b: 42)
    public var contentViewAlpha: CGFloat = 1.0
    
    public var successMessage: String = "Thanks for Voting!"
    public var errorMessage: String = "Failed to submit. Please try again later.\n"
    
    // MARK: - Alert View Configuration
    // Container
    public var alertContainerBackgroundColor: UIColor = .white
    public var alertContainerCornerRadius: CGFloat = 16
    public var alertContainerWidth: CGFloat = 300
    public var alertContainerShadowColor: UIColor = .black
    public var alertContainerShadowOpacity: Float = 0.2
    public var alertContainerShadowOffset: CGSize = CGSize(width: 0, height: 4)
    public var alertContainerShadowRadius: CGFloat = 12
    
    // Overlay
    public var alertOverlayBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.5)
    
    // Icon
    public var alertIconSize: CGFloat = 60
    public var alertIconTopMargin: CGFloat = 32
    public var alertSuccessIconName: String = "checkmark-circle-fill"
    public var alertErrorIconName: String = "xmark-circle-fill"
    public var alertSuccessIconColor: UIColor = .systemGreen
    public var alertErrorIconColor: UIColor = .systemRed
    
    // Message
    public var alertMessageFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    public var alertMessageColor: UIColor = .gray
    public var alertMessageTopMargin: CGFloat = 12
    
    // Button
    public var alertButtonFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    public var alertButtonTitle: String = "OK"
    public var alertButtonCornerRadius: CGFloat = 8
    public var alertButtonHeight: CGFloat = 48
    public var alertButtonTopMargin: CGFloat = 24
    public var alertButtonBottomMargin: CGFloat = 24
    public var alertSuccessButtonBackgroundColor: UIColor = .systemGreen
    public var alertErrorButtonBackgroundColor: UIColor = .systemRed
    public var alertButtonTitleColor: UIColor = .white
    
    // Spacing
    public var alertHorizontalPadding: CGFloat = 24
    
    // Animation
    public var alertFadeAnimationDuration: TimeInterval = 0.3
    public var alertScaleAnimationDuration: TimeInterval = 0.5
    public var alertScaleAnimationDamping: CGFloat = 0.7
    public var alertScaleAnimationVelocity: CGFloat = 0.5
    public var alertInitialScale: CGFloat = 0.8
}

public enum ImageType: String {
    case VoteIcon1 = "Vote1"
    case VoteIcon2 = "Vote2"
    case VoteIcon3 = "Vote3"
    case VoteIcon4 = "Vote4"
    case VoteIcon5 = "Vote5"
    case gear = "gear"
}
