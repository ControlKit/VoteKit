//
//  File.swift
//  
//
//  Created by Maziar Saadatfar on 10/18/23.
//

import Foundation
import UIKit
public class VoteViewConfig {
    public init(lang: String) {
        self.lang = lang
    }
    public let lang: String
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
}

public enum ImageType: String {
    case VoteIcon1 = "Vote1"
    case VoteIcon2 = "Vote2"
    case VoteIcon3 = "Vote3"
    case VoteIcon4 = "Vote4"
    case VoteIcon5 = "Vote5"
    case gear = "gear"
}
