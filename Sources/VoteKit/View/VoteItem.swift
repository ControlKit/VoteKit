//
//  VoteItem.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 9/28/25.
//
import UIKit
class VoteItem: UIView {
    public var vote: VoteOption {
        didSet {
            setNeedsDisplay()
        }
    }
    public var isSelected: Bool = false {
        didSet {
            let img = isSelected ? ImageHelper.image("selected") : ImageHelper.image("unselected")
            radioButton.setImage(img, for: .normal)
            setNeedsDisplay()
        }
    }
    
    public var font: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular) {
        didSet {
            titleLabel.font = font
            setNeedsDisplay()
        }
    }
    public var titleColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleColor
            setNeedsDisplay()
        }
    }
    
    public var title: String = String() {
        didSet {
            titleLabel.text = title
            setNeedsDisplay()
        }
    }
    
    lazy var voteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = font
        headerTitle.text = title
        headerTitle.textColor = titleColor
        headerTitle.textAlignment = .left
        headerTitle.numberOfLines = 0
        return headerTitle
    }()
    lazy var radioButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("", for: .normal)
        let img = isSelected ? ImageHelper.image("selected") : ImageHelper.image("unselected")
        button.setImage(img, for: .normal)
        return button
    }()
    
    init(
        vote: VoteOption,
        font: UIFont,
        titleColor: UIColor,
        title: String,
        isSelected: Bool = false
    ) {
        self.vote = vote
        self.isSelected = isSelected
        self.font = font
        self.titleColor = titleColor
        self.title = title
        super.init(frame: .zero)
        setViewConstraint()
        self.addSubview(voteStackView)
        voteStackView.fixInView(self)
        voteStackView.addArrangedSubview(radioButton)
        voteStackView.addArrangedSubview(titleLabel)
        setTitleViewConstraint()
        setRadioButtonConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setViewConstraint() {
        let width = UIScreen.main.bounds.width - paddingWidth
        var height = title.heightWithConstrainedWidth(width: width,
                                                      font: font)
        height = height > 30 ? 30 : height
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: height).isActive = true
    }
    
    public func setTitleViewConstraint() {
        let width = UIScreen.main.bounds.width - paddingWidth
        var height = title.heightWithConstrainedWidth(width: width,
                                                      font: font)
        height = height > 30 ? 30 : height
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: titleLabel,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: height).isActive = true
    }
    public func setRadioButtonConstraint() {
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: radioButton,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: voteStackView,
            attribute: .centerY,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: radioButton,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 16).isActive = true
        NSLayoutConstraint(
            item: radioButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 16).isActive = true
    }
}
