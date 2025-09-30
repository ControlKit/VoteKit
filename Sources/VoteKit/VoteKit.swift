// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import UIKit
import Combine

public let voteKit_Version: String = "1.0.0"
public class VoteKit: Votable {
    public let voteService: VoteServiceProtocol!
    public init(voteService: VoteServiceProtocol = VoteService()) {
        self.voteService = voteService
    }
    @MainActor
    public func configure(root: UIViewController,
                          modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
                          config: VoteServiceConfig) async {
        Task {
            let request = VoteRequest(appId: config.appId,
                                      name: config.name,
                                      sdkVersion: config.sdkVersion)
            guard let response = try await self.getVote(request: request) else {
                return
            }
            let viewModel = DefaultVoteViewModel(
                serviceConfig: config,
                response: response
            )
            let vc = VoteViewController(
                viewModel: viewModel,
                config: config
            )
            vc.modalPresentationStyle = modalPresentationStyle
            if config.viewConfig.style != .fullscreen1 {
                vc.modalPresentationStyle = .overCurrentContext
            }
            DispatchQueue.main.async {
                root.present(vc, animated: true)
            }
        }
    }
}
