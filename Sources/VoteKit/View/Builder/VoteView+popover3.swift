//
//  File.swift
//
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import Foundation
import UIKit

public class VoteView_Popover3: UIView, VoteViewProtocol {
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
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = config.contentViewBackColor
        contentView.alpha = 0.8
        return contentView
    }()
    
    lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.backgroundColor = config.closeButtonBackColor
        closeButton.titleLabel?.textColor = config.closeButtonTitleColor
        closeButton.setTitle(config.closeButtonNormalTitle, for: .normal)
        closeButton.setCurvedView(cornerRadius: config.closeButtonCornerRadius,
                                  borderWidth: config.closeButtonBorderWidth,
                                  borderColor: config.closeButtonBorderColor)
        closeButton.titleLabel?.font = config.closeButtonFont
        closeButton.setTitleColor(config.closeButtonTitleColor, for: .normal)
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return closeButton
    }()
    
    lazy var popupView: UIView = {
        let popupView = UIView()
        popupView.backgroundColor = config.popupViewBackColor
        popupView.setCurvedView(cornerRadius: config.popupViewCornerRadius)
        return popupView
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
    
    public func setup() {
        addSubview(contentView)
        contentView.fixInView(self)
        contentView.addSubview(contentBackGroundImageView)
        contentBackGroundImageView.fixInView(contentView)
        addSubview(popupView)
        addSubview(iconImageView)
        popupView.addSubview(headerTitle)
        popupView.addSubview(descriptionLabel)
        popupView.addSubview(button)
        popupView.addSubview(closeButton)
        setPopupViewConstraint()
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
    
    public func setPopupViewConstraint() {
        let width = UIScreen.main.bounds.width - 90
        let height = config.descriptionText.heightWithConstrainedWidth(width: width,
                                                                       font: config.descriptionFont)
        popupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: popupView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: popupView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: 0).isActive = true
        popupView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: 60).isActive = true
        NSLayoutConstraint(
            item: popupView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 400 + height).isActive = true
    }
    
    public func setUpdateImageViewConstraint() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: iconImageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: popupView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: iconImageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: popupView,
            attribute: .top,
            multiplier: 1,
            constant: -40).isActive = true
        NSLayoutConstraint(
            item: iconImageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: 175).isActive = true
        NSLayoutConstraint(
            item: iconImageView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 150).isActive = true
    }
    
    public func setTitleViewConstraint() {
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: headerTitle,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: popupView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: headerTitle,
            attribute: .top,
            relatedBy: .equal,
            toItem: iconImageView,
            attribute: .bottom,
            multiplier: 1,
            constant: 41).isActive = true
        
        headerTitle.leadingAnchor.constraint(
            equalTo: popupView.leadingAnchor,
            constant: 21).isActive = true
        
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
            toItem: popupView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: headerTitle,
            attribute: .bottom,
            multiplier: 1,
            constant: 24).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(
            equalTo: popupView.leadingAnchor,
            constant: 21).isActive = true
        
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
            toItem: popupView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: button,
            attribute: .top,
            relatedBy: .greaterThanOrEqual,
            toItem: descriptionLabel,
            attribute: .bottom,
            multiplier: 1,
            constant: 30).isActive = true
        NSLayoutConstraint(
            item: button,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: 250).isActive = true
        NSLayoutConstraint(
            item: button,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 44).isActive = true
    }
    
    public func setCloseButtonConstraint() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: closeButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: popupView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: closeButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: button,
            attribute: .bottom,
            multiplier: 1,
            constant: 8).isActive = true
        NSLayoutConstraint(
            item: closeButton,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: popupView,
            attribute: .bottom,
            multiplier: 1,
            constant: -50).isActive = true
        NSLayoutConstraint(
            item: closeButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: 250).isActive = true
        NSLayoutConstraint(
            item: closeButton,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 44).isActive = true
    }
}

public class Popover3VoteViewConfig: VoteViewConfig {
    public override init(lang: String) {
        super.init(lang: lang)
        style = .popover3
        popupViewBackColor = .white
        titleFont = UIFont.systemFont(ofSize: 20, weight: .heavy)
        descriptionFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleColor = UIColor(r: 24, g: 32, b: 53)
        descriptionTextColor = UIColor(r: 96, g: 98, b: 104)
        imageType = .VoteIcon1
        buttonTitleColor = .white
        closeButtonBorderColor = UIColor(r: 253, g: 105, b: 42)
        closeButtonTitleColor = UIColor(r: 253, g: 105, b: 42)
        closeButtonBorderWidth = 1
    }
}
