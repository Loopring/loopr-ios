//
//  Order.swift
//  loopr-ios
//
//  Created by Xiao Dou Dou on 2/1/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import Foundation

class Order {
    
    let originalOrder: OriginalOrder
    let orderStatus: OrderStatus
    let dealtAmountB: Double
    let dealtAmountS: Double
    let tradingPairDescription: String
    let manager = AssetDataManager.shared
    
    init(originalOrder: OriginalOrder, orderStatus: OrderStatus, dealtAmountB: String, dealtAmountS: String) {
        self.originalOrder = originalOrder
        self.orderStatus = orderStatus
        self.dealtAmountB = manager.getAmount(of: originalOrder.tokenB, from: dealtAmountB)!
        self.dealtAmountS = manager.getAmount(of: originalOrder.tokenS, from: dealtAmountS)!
        
        if originalOrder.tokenB == "WETH" {
            tradingPairDescription = "\(originalOrder.tokenS) / \(originalOrder.tokenB)"
        } else {
            tradingPairDescription = "\(originalOrder.tokenB) / \(originalOrder.tokenS)"
        }
    }
}
