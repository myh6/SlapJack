//
//  Dealers.swift
//  SlapJack
//
//  Created by curry敏 on 2021/7/26.
//

import Foundation

struct Dealers {
    
    var dealerTotal: Int = 0
    var hasOneOne = false
    private var numbersOfTurns: Int = 0
    
    mutating func setDealersN(_ number: Int){
        self.dealerTotal = number
    }
    
    mutating func calculateDealer(inputN: Int) -> Int {
//        if inputN == 1 {
//            let checkN = 11 + dealerTotal
//            if checkN > 21 {
//                dealerTotal = 1 + dealerTotal
//                return dealerTotal  //ace represents 1
//            } else if checkN == 21 {
//                dealerTotal = 21 //ace represents 11
//                return dealerTotal
//            } else {
//                dealerTotal = checkN
//                return dealerTotal //checkN < 21 when ace represents 11
//            }
//        } else {
//        let result = inputN + dealerTotal
//        setDealersN(result)
//        }
//        return dealerTotal
        numbersOfTurns += 1
        
        if inputN == 1 {
            dealerTotal += 11
            hasOneOne = true
            if dealerTotal > 21 && hasOneOne {
                dealerTotal -= 10
                return dealerTotal
            }
        } else {
            dealerTotal += inputN
            if dealerTotal > 21 && hasOneOne {
                dealerTotal -= 10
                hasOneOne = false
                return dealerTotal
            }
        }
        return dealerTotal
    }
    
    
}
