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
        stackView.spacing = 1
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
    public func setTitleViewConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: titleLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: voteStackView,
            attribute: .top,
            multiplier: 1,
            constant: 4).isActive = true
        titleLabel.leadingAnchor.constraint(
            equalTo: voteStackView.leadingAnchor,
            constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: voteStackView.trailingAnchor,
            constant: -8).isActive = true
        
        NSLayoutConstraint(
            item: titleLabel,
            attribute: .height,
            relatedBy: .greaterThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 30).isActive = true
    }
    public func setRadioButtonConstraint() {
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: radioButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: voteStackView,
            attribute: .top,
            multiplier: 1,
            constant: 4).isActive = true
        radioButton.leadingAnchor.constraint(
            equalTo: voteStackView.leadingAnchor,
            constant: 8).isActive = true
        radioButton.trailingAnchor.constraint(
            equalTo: voteStackView.trailingAnchor,
            constant: -8).isActive = true
        
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
