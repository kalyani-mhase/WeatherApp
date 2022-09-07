//
//  Extension.swift
//  WeatherApp
//
//  Created by Admin on 07/02/22.
//

import Foundation
extension Double{
    func rounded(toplace place : Int)->Double{
        let Divisor  = pow(10.0,Double(place))
        return(self * Divisor).rounded() / Divisor
    }
}
    extension Date{
        func daysOfTheWeek()->String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: self)
          
        }
    }

