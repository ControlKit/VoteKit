//
//  VoteViewStyle.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation
import UIKit
import ControlKitBase

public enum VoteViewStyle {
    case fullscreen1
    case popover1
    case popover2
    case popover3
    case popover4
    public static func make(viewModel: VoteViewModel,
                            config: VoteViewConfig) -> VoteViewProtocol {
        switch config.style {
        case .fullscreen1:
            return VoteView_FullScreen1(viewModel: viewModel,
                                               config: config)
        case .popover1:
            return VoteView_Popover1(viewModel: viewModel,
                                            config: config)
        case .popover2:
            return VoteView_Popover2(viewModel: viewModel,
                                            config: config)
        case .popover3:
            return VoteView_Popover3(viewModel: viewModel,
                                               config: config)
        case .popover4:
            return VoteView_Popover4(viewModel: viewModel,
                                               config: config)
        }
    }
    
    public static func getViewConfigWithStyle(style: VoteViewStyle, lang: CKLanguage) -> VoteViewConfig {
        switch style {
        case .fullscreen1:
            FullScreen1VoteViewConfig(lang: lang)
        case .popover1:
            Popover1VoteViewConfig(lang: lang)
        case .popover2:
            Popover2VoteViewConfig(lang: lang)
        case .popover3:
            Popover3VoteViewConfig(lang: lang)
        case .popover4:
            Popover4VoteViewConfig(lang: lang)
        }
    }
}
