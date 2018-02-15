//
//  MarketSwipeViewType.swift
//  loopr-ios
//
//  Created by xiaoruby on 2/14/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import Foundation


enum MarketSwipeViewType: String, CustomStringConvertible {
    
    case favorite = "Favorite"
    case LRC = "LRC"
    case ETH = "ETH"
    case all = "All"
    
    var description: String {
        switch self {
        case .favorite: return "Favorite"
        case .LRC: return "LRC"
        case .ETH: return "ETH"
        case .all: return "All"
        }
    }

}
