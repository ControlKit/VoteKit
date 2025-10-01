//
//  File.swift
//
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import Foundation
import UIKit
public class VoteView_Popover3: UIView, VoteViewProtocol, RadioButtonDelegate {
    var config: VoteViewConfig
    var viewModel: VoteViewModel
    weak public var delegate: VoteDelegate?
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = config.contentViewBackColor
        contentView.alpha = config.contentViewAlpha
        return contentView
    }()
    
    lazy var popupView: UIView = {
        let popupView = UIView()
        popupView.backgroundColor = config.popupViewBackColor
        popupView.setCurvedView(cornerRadius: config.popupViewCornerRadius)
        return popupView
    }()
    
    lazy var headerTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = config.titleFont
        headerTitle.text = config.title
        headerTitle.textColor = config.titleColor
        headerTitle.textAlignment = .left
        headerTitle.numberOfLines = 0
        return headerTitle
    }()
    
    lazy var questionView: UIView = {
        let popupView = UIView()
        popupView.backgroundColor = config.questionViewBackColor
        popupView.setCurvedView(cornerRadius: config.questionViewCornerRadius)
        return popupView
    }()
    
    lazy var voteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 1
        return stackView
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = config.buttonBackColor
        button.titleLabel?.textColor = config.buttonTitleColor
        button.setTitle(config.buttonNormalTitle, for: .normal)
        button.setCurvedView(cornerRadius: config.buttonCornerRadius,
                             borderWidth: config.buttonBorderWidth,
                             borderColor: config.buttonBorderColor)
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
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
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return closeButton
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public required init(viewModel: VoteViewModel,
                         config: VoteViewConfig) {
        self.config = config
        self.viewModel = viewModel
        self.config = VoteViewPresenter(data: viewModel.response.data, config: self.config).config
        super.init(frame: .zero)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup() {
        addSubview(contentView)
        contentView.fixInView(self)
        contentView.addSubview(popupView)
        popupView.addSubview(headerTitle)
        popupView.addSubview(questionView)
        questionView.addSubview(voteStackView)
        popupView.addSubview(closeButton)
        popupView.addSubview(submitButton)
        setPopupViewConstraint()
        setTitleViewConstraint()
        setQuestionViewConstraint()
        setVoteStackViewConstraint()
        setSubmitButtonConstraint()
        setCloseButtonConstraint()
        addVotesToStackView()
    }
    func addVotesToStackView() {
        guard let voteOptions = viewModel.response.data?.vote_options else {
            return
        }
        let questionLabel = getVoteQuestion(config.question)
        voteStackView.addArrangedSubview(questionLabel)
        setQuestionLabelConstraint(questionLabel)
        for voteOption in voteOptions {
            let voteOptionView = getVoteOption(voteOption)
            voteOptionView.delegate = self
            voteStackView.addArrangedSubview(voteOptionView)
        }
    }
    func getVoteQuestion(_ q: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = config.questionFont
        label.text = config.question
        label.textColor = config.questionColor
        label.textAlignment = .left
        return label
    }
    func getVoteOption(_ voteOption: VoteOption) -> VoteItem {
        let item = VoteItem(
            vote: voteOption,
            font: config.voteItemFont,
            titleColor: config.voteItemColor,
            title: getOptionTitle(voteOption)
        )
        return item
    }
    
    func radioButtonTapped(vote: VoteOption) {
        viewModel.selectedVoteOption = vote
        for voteItem in voteStackView.subviews {
            if let voteItem = voteItem as? VoteItem, voteItem.vote.id != vote.id {
                voteItem.isSelected = false
            }
        }
    }
    
    func getOptionTitle(_ voteOption: VoteOption) -> String {
        return VoteViewPresenter(
            data: nil,
            config: config
        ).getLocalizeString(voteOption.title ?? []) ?? ""
    }
    
    @objc
    func submitButtonTapped() {
        delegate?.submit()
    }
    
    @objc
    func closeButtonTapped() {
        delegate?.dismiss()
    }
    
    func getHeigth() -> CGFloat {
        let width = UIScreen.main.bounds.width - paddingWidth
        var height = config.question.heightWithConstrainedWidth(width: width,
                                                                font: config.questionFont)
        for voteOption in viewModel.response.data?.vote_options ?? [] {
            height += getOptionTitle(voteOption).heightWithConstrainedWidth(width: width,
                                                                            font: config.voteItemFont) + paddingHeight
        }
        return height
    }
    
    public func setPopupViewConstraint() {
        var height = getHeigth()
        height += 300
        popupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: popupView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: popupView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerY,
            multiplier: 1,
            constant: 0).isActive = true
        popupView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 24).isActive = true
        popupView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -24).isActive = true
        NSLayoutConstraint(
            item: popupView,
            attribute: .height,
            relatedBy: .greaterThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: height).isActive = true
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
            toItem: popupView,
            attribute: .top,
            multiplier: 1,
            constant: 60).isActive = true
        
        headerTitle.leadingAnchor.constraint(
            equalTo: popupView.leadingAnchor,
            constant: 28).isActive = true
        headerTitle.trailingAnchor.constraint(
            equalTo: popupView.trailingAnchor,
            constant: -28).isActive = true
        
        NSLayoutConstraint(
            item: headerTitle,
            attribute: .height,
            relatedBy: .greaterThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 30).isActive = true
    }
    
    public func setQuestionViewConstraint() {
        var height = getHeigth()
        height += 50
        questionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: questionView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: popupView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: questionView,
            attribute: .top,
            relatedBy: .equal,
            toItem: headerTitle,
            attribute: .bottom,
            multiplier: 1,
            constant: 33).isActive = true
        
        questionView.leadingAnchor.constraint(
            equalTo: popupView.leadingAnchor,
            constant: 14).isActive = true
        questionView.trailingAnchor.constraint(
            equalTo: popupView.trailingAnchor,
            constant: -14).isActive = true
        
        NSLayoutConstraint(
            item: questionView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: height).isActive = true
    }
    
    public func setVoteStackViewConstraint() {
        voteStackView.translatesAutoresizingMaskIntoConstraints = false
        voteStackView.leadingAnchor.constraint(
            equalTo: questionView.leadingAnchor,
            constant: 16).isActive = true
        voteStackView.trailingAnchor.constraint(
            equalTo: questionView.trailingAnchor,
            constant: -16).isActive = true
        voteStackView.topAnchor.constraint(
            equalTo: questionView.topAnchor,
            constant: 16).isActive = true
        voteStackView.bottomAnchor.constraint(
            equalTo: questionView.bottomAnchor,
            constant: -16).isActive = true
    }
    
    public func setQuestionLabelConstraint(_ label: UILabel) {
        let width = UIScreen.main.bounds.width - paddingWidth
        let height = config.question.heightWithConstrainedWidth(width: width,
                                                                font: config.questionFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: label,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: voteStackView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: label,
            attribute: .height,
            relatedBy: .greaterThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: height).isActive = true
    }
    
    public func setCloseButtonConstraint() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: closeButton,
            attribute: .right,
            relatedBy: .equal,
            toItem: popupView,
            attribute: .right,
            multiplier: 1,
            constant: -8).isActive = true
        NSLayoutConstraint(
            item: closeButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: popupView,
            attribute: .top,
            multiplier: 1,
            constant: 8).isActive = true
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
    
    public func setSubmitButtonConstraint() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: submitButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: popupView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: submitButton,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: popupView,
            attribute: .bottom,
            multiplier: 1,
            constant: -30).isActive = true
        NSLayoutConstraint(
            item: submitButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: 193).isActive = true
        NSLayoutConstraint(
            item: submitButton,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 52).isActive = true
    }
}

public class Popover3VoteViewConfig: VoteViewConfig {
    public override init(lang: String) {
        super.init(lang: lang)
        style = .popover3
    }
}
