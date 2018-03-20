//
//  OrderDataManager.swift
//  loopr-ios
//
//  Created by xiaoruby on 2/5/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import Foundation

class OrderDataManager {

    static let shared = OrderDataManager()

    private var orders: [Order]

    private init() {
        orders = []
    }
    
    func getOrders(orderStatuses: [OrderStatus]? = nil) -> [Order] {
        guard let orderStatuses = orderStatuses else {
            return orders
        }
        
        return orders.filter { (order) -> Bool in
            orderStatuses.contains(order.orderStatus)
        }
    }

    func getOrdersFromServer() {
        LoopringAPIRequest.getOrders(pageSize: 40) { orders, error in
            guard error == nil && orders != nil else {
                return
            }
            self.orders = orders!
        }
    }

}
