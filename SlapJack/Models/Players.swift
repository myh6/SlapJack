//
//  Players.swift
//  SlapJack
//
//  Created by curry敏 on 2021/7/26.
//
//
import Foundation

struct Players {
    
    var numberTotal: Int = 0
    var hasEleven = false
    
    mutating func setNumber(_ number: Int) {
        self.numberTotal = number
    }
    
    mutating func calculation(inputnumber: Int) -> Int{
//        if inputnumber == 1 {
//            let checkN = 11 + numberTotal
//            if checkN > 21 {
//                numberTotal = 1 + numberTotal
//                return numberTotal  //ace represents 1
//            } else if checkN == 21 {
//                numberTotal = 21 //ace represents 11
//                return numberTotal
//            } else {
//                numberTotal = checkN
//                return numberTotal //checkN < 21 when ace represents 11
//            }
//        } else {
//        let result = inputnumber + numberTotal
//        setNumber(result)
//        }
//        return numberTotal
//    }
        if inputnumber == 1 {
            numberTotal += 11
            hasEleven = true
            if numberTotal > 21 && hasEleven {
                numberTotal -= 10
                return numberTotal
            }
        } else {
            numberTotal += inputnumber
            if numberTotal > 21 && hasEleven {
                numberTotal -= 10
                hasEleven = false
                return numberTotal
            }
        }
        return numberTotal
    }

    
}
