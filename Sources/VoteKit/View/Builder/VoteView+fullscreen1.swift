//
//  File.swift
//
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import Foundation
import UIKit

public protocol VoteDelegate: AnyObject {
    func dismiss()
}

public class VoteView_FullScreen1: UIView, VoteViewProtocol {
    var config: VoteViewConfig
    var viewModel: VoteViewModel
    
    weak public var delegate: VoteDelegate?
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = config.buttonBackColor
        button.titleLabel?.textColor = config.buttonTitleColor
        button.setTitle(config.buttonNormalTitle, for: .normal)
        button.setCurvedView(cornerRadius: config.buttonCornerRadius,
                             borderWidth: config.buttonBorderWidth,
                             borderColor: config.buttonBorderColor)
        button.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        button.titleLabel?.font = config.buttonFont
        button.setTitleColor(config.buttonTitleColor, for: .normal)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        let img = closeButtonIcon(color: config.closeButtonImageColor,
                                  image: config.closeButtonImage)
        closeButton.setImage(img, for: .normal)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return closeButton
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = config.contentViewBackColor
        return contentView
    }()
    
    lazy var contentBackGroundImageView: UIImageView = {
        let contentBackGroundImageView = UIImageView()
        contentBackGroundImageView.image = config.contentBackGroundImage
        return contentBackGroundImageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        setIcon(color: config.imageColor,
                image: config.image,
                imageType: config.imageType,
                imageView: imageView)
        return imageView
    }()
    
    lazy var headerTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = config.titleFont
        headerTitle.text = config.title
        headerTitle.textColor = config.titleColor
        headerTitle.textAlignment = .center
        headerTitle.numberOfLines = 0
        return headerTitle
    }()
    
    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = config.descriptionFont
        descriptionLabel.text = config.descriptionText
        descriptionLabel.textColor = config.descriptionTextColor
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.setCurvedView(cornerRadius: 20)
    }
    
    public required init(viewModel: VoteViewModel,
                         config: VoteViewConfig) {
        self.config = config
        self.viewModel = viewModel
        self.config = VoteViewPresenter(data: viewModel.response.data, config: self.config).config
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func commonInit() {
        contentView.fixInView(self)
    }
    
    public func setup() {
        addSubview(contentView)
        contentView.fixInView(self)
        contentView.addSubview(contentBackGroundImageView)
        contentBackGroundImageView.fixInView(contentView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(closeButton)
        contentView.addSubview(button)
        contentView.addSubview(headerTitle)
        contentView.addSubview(descriptionLabel)
        commonInit()
        setUpdateImageViewConstraint()
        setTitleViewConstraint()
        setDescriptionConstraint()
        setButtonConstraint()
        setCloseButtonConstraint()
    }
    
    @objc
    func openLink() {
        viewModel.openLink()
        delegate?.dismiss()
    }
    
    @objc
    func dismiss() {
        delegate?.dismiss()
    }
    
    public func setUpdateImageViewConstraint() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: iconImageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: iconImageView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: headerTitle,
            attribute: .top,
            multiplier: 1,
            constant: -70).isActive = true
        NSLayoutConstraint(
            item: iconImageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: 191).isActive = true
        NSLayoutConstraint(
            item: iconImageView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 139).isActive = true
    }
    
    public func setTitleViewConstraint() {
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: headerTitle,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: headerTitle,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: descriptionLabel,
            attribute: .top,
            multiplier: 1,
            constant: -16).isActive = true
        
        headerTitle.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 24).isActive = true
        
        NSLayoutConstraint(
            item: headerTitle,
            attribute: .height,
            relatedBy: .greaterThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 30).isActive = true
    }
    
    public func setDescriptionConstraint() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerY,
            multiplier: 1,
            constant: 0).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 24).isActive = true
        
        NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .height,
            relatedBy: .greaterThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 50).isActive = true
    }
    
    public func setButtonConstraint() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: button,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: button,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .bottom,
            multiplier: 1,
            constant: -60).isActive = true
        NSLayoutConstraint(
            item: button,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: 222).isActive = true
        NSLayoutConstraint(
            item: button,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 56).isActive = true
    }
    
    public func setCloseButtonConstraint() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: closeButton,
            attribute: .left,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .left,
            multiplier: 1,
            constant: 16).isActive = true
        NSLayoutConstraint(
            item: closeButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .top,
            multiplier: 1,
            constant: 48).isActive = true
        NSLayoutConstraint(
            item: closeButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 40).isActive = true
        NSLayoutConstraint(
            item: closeButton,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 40).isActive = true
    }
}

public class FullScreen1VoteViewConfig: VoteViewConfig {
    public override init(lang: String) {
        super.init(lang: lang)
        style = .fullscreen1
    }
}

class ImageHelper {
    static var resolvedBundle: Bundle {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle(for: self)
#endif
    }
    
    static func image(_ name: String) -> UIImage? {
        return UIImage(named: name,
                       in: resolvedBundle,
                       compatibleWith: nil)
    }
}
