//
//  VoteViewController.swift
//  
//
//  Created by Maziar Saadatfar on 10/21/23.
//

import UIKit

class VoteViewController: UIViewController {
    let viewModel: VoteViewModel
    let config: VoteServiceConfig

    init(viewModel: VoteViewModel, config: VoteServiceConfig) {
        self.viewModel = viewModel
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let VoteView = VoteViewStyle.make(viewModel: viewModel,
                                          config: config.viewConfig)
        view.addSubview(VoteView)
        VoteView.delegate = self
        VoteView.fixInView(view)
        viewModel.setAction(.view)
    }
}

extension VoteViewController: VoteDelegate {
    func submit() {
        Task {
            do {
                let result = try await viewModel.setVote()
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showErrorAlert(error: error.localizedDescription)
                    }
                case .success, .noContent:
                    DispatchQueue.main.async {
                        self.showSuccessAlert()
                    }
                default:
                    print("nothing")
                }
            } catch {
                DispatchQueue.main.async {
                    self.showErrorAlert(error: self.config.viewConfig.errorMessage + error.localizedDescription)
                }
            }
        }
    }
    
    private func showSuccessAlert() {
        let alertView = AlertView(config: config.viewConfig)
        alertView.configure(
            type: .success,
            message: config.viewConfig.successMessage,
            onDismiss: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
        alertView.show(in: self.view)
    }
    
    private func showErrorAlert(error: String) {
        let alertView = AlertView(config: config.viewConfig)
        alertView.configure(
            type: .error,
            message: error,
            onDismiss: nil
        )
        alertView.show(in: self.view)
    }
    
    func dismiss() {
        viewModel.setAction(.cancel)
        self.dismiss(animated: true)
    }
}
