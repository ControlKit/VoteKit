// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import UIKit
import Combine
import ControlKitBase

public let voteKit_Version: String = "1.0.0"
public let latestVoteKey: String = "latestVoteKey"
public class VoteKit: Votable {
    public let voteService: GenericServiceProtocol
    public init(voteService: GenericServiceProtocol = GenericService()) {
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
            guard let response = try await self.getVote(request: request)?.value else {
                return
            }
            
            guard let id = response.data?.id,
                  id > UserDefaults.standard.string(forKey: latestVoteKey) ?? String() else {
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
