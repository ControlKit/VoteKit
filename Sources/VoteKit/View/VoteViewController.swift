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
        if (viewModel.selectedVoteOption) != nil {
            viewModel.setVote()
            viewModel.setAction(.submit)
            dismiss(animated: true)
        }
    }
    
    func dismiss() {
        viewModel.setAction(.cancel)
        self.dismiss(animated: true)
    }
}
