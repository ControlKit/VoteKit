//
//  VotePresenter.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 8/26/25.
//
import Foundation
import UIKit
public struct VoteViewPresenter {
    var config: VoteViewConfig
    public init(data: VoteModel?, config: VoteViewConfig) {
        self.config = config
        if let localTitle = data?.title,
            let title = getLocalizeString(localTitle) { self.config.title = title }
        
        if let localDescription = data?.description,
           let description = getLocalizeString(localDescription) { self.config.question = description }
        
        if let localSubmitButtonTitle = data?.accept_button_title,
           let buttonTitle = getLocalizeString(localSubmitButtonTitle) { self.config.buttonNormalTitle = buttonTitle }
        
        if let localCancelButtonTitle = data?.cancel_button_title,
           let cancelButtonTitle = getLocalizeString(localCancelButtonTitle) { self.config.closeButtonNormalTitle = cancelButtonTitle }
        
    }
    
    func getLocalizeString(_ localize: VoteLocalString) -> String? {
        guard let localizeString = localize.first(where: { $0.language == config.lang }) else {
            if let defaultLang = localize.first(where: { $0.language == "en" }) {
                return defaultLang.content
            } else {
                return nil
            }
        }
        return localizeString.content
    }
}
