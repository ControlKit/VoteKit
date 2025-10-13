//
//  AlertView.swift
//  ContactSupportKit
//
//  Created by Maziar Saadatfar on 10/13/25.
//

import UIKit
import ControlKitBase

public enum AlertType {
    case success
    case error
}

public class AlertView: UIView {
    
    // MARK: - Properties
    let config: VoteViewConfig
    
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let messageLabel = UILabel()
    private let dismissButton = UIButton(type: .system)
    
    private var dismissAction: (() -> Void)?
    private var autoDismissTimer: Timer?
    
    // MARK: - Initialization
    public init(config: VoteViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        // Background overlay
        backgroundColor = config.alertOverlayBackgroundColor
        
        // Configure container view
        containerView.backgroundColor = config.alertContainerBackgroundColor
        containerView.layer.cornerRadius = config.alertContainerCornerRadius
        containerView.layer.shadowColor = config.alertContainerShadowColor.cgColor
        containerView.layer.shadowOpacity = config.alertContainerShadowOpacity
        containerView.layer.shadowOffset = config.alertContainerShadowOffset
        containerView.layer.shadowRadius = config.alertContainerShadowRadius
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure icon
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure message label
        messageLabel.font = config.alertMessageFont
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = config.alertMessageColor
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure dismiss button
        dismissButton.setTitle(config.alertButtonTitle, for: .normal)
        dismissButton.titleLabel?.font = config.alertButtonFont
        dismissButton.layer.cornerRadius = config.alertButtonCornerRadius
        dismissButton.setTitleColor(config.alertButtonTitleColor, for: .normal)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            // Container view
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: config.alertContainerWidth),
            
            // Icon
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: config.alertIconTopMargin),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: config.alertIconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: config.alertIconSize),

            // Message
            messageLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: config.alertMessageTopMargin),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: config.alertHorizontalPadding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -config.alertHorizontalPadding),
            
            // Dismiss button
            dismissButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: config.alertButtonTopMargin),
            dismissButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: config.alertHorizontalPadding),
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -config.alertHorizontalPadding),
            dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -config.alertButtonBottomMargin),
            dismissButton.heightAnchor.constraint(equalToConstant: config.alertButtonHeight)
        ])
        
        dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
    }
    
    // MARK: - Configuration
    public func configure(
        type: AlertType,
        message: String,
        autoDismissAfter seconds: TimeInterval? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.dismissAction = onDismiss
        messageLabel.text = message
        
        switch type {
        case .success:
            configureSuccessStyle()
        case .error:
            configureErrorStyle()
        }
        
        if let seconds = seconds {
            autoDismissTimer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { [weak self] _ in
                self?.dismiss()
            }
        }
    }
    
    private func configureSuccessStyle() {
        dismissButton.backgroundColor = config.alertSuccessButtonBackgroundColor
        dismissButton.setTitleColor(config.alertButtonTitleColor, for: .normal)
        
        // Create success checkmark icon
        let imageConfig = ImageHelper.image(config.alertSuccessIconName)?.imageWithColor(color: config.alertSuccessIconColor)
        iconImageView.image = imageConfig
    }
    
    private func configureErrorStyle() {
        dismissButton.backgroundColor = config.alertErrorButtonBackgroundColor
        dismissButton.setTitleColor(config.alertButtonTitleColor, for: .normal)
        
        // Create error icon
        let imageConfig = ImageHelper.image(config.alertErrorIconName)?.imageWithColor(color: config.alertErrorIconColor)
        iconImageView.image = imageConfig
    }
    
    // MARK: - Actions
    @objc private func dismissTapped() {
        dismiss()
    }
    
    private func dismiss() {
        autoDismissTimer?.invalidate()
        autoDismissTimer = nil
        
        UIView.animate(withDuration: config.alertFadeAnimationDuration, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            self.dismissAction?()
        }
    }
    
    // MARK: - Public Methods
    public func show(in view: UIView) {
        frame = view.bounds
        alpha = 0
        view.addSubview(self)
        
        // Animate in
        UIView.animate(withDuration: config.alertFadeAnimationDuration) {
            self.alpha = 1
        }
        
        // Scale animation for container
        containerView.transform = CGAffineTransform(scaleX: config.alertInitialScale, y: config.alertInitialScale)
        UIView.animate(
            withDuration: config.alertScaleAnimationDuration,
            delay: 0,
            usingSpringWithDamping: config.alertScaleAnimationDamping,
            initialSpringVelocity: config.alertScaleAnimationVelocity,
            options: .curveEaseOut,
            animations: {
                self.containerView.transform = .identity
            }
        )
    }
    
    deinit {
        autoDismissTimer?.invalidate()
    }
}
