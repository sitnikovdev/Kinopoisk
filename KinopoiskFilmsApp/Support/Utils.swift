//
//  Utils.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 14.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import UIKit

final class Utils {
   static  func setColorForRating(_ rating: Double) -> UIColor {
        // Set colorized film rating
        var color: UIColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 0, alpha: 1)
        
        switch rating {
        case    7...: // from 7 and higher - #007b00
            color = #colorLiteral(red: 0, green: 0.4823529412, blue: 0, alpha: 1)
        case 5...6: // from 5 to 6 inclusive - #5f5f5f
            color = #colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1)
        case 0..<5: // below 5 - #ff0b0b
            color = #colorLiteral(red: 1, green: 0.0431372549, blue: 0.0431372549, alpha: 1)
        default:
            // From 6 to 7 - undefined, set default color
            color = #colorLiteral(red: 0.3999555707, green: 0.4000248015, blue: 0.1652560234, alpha: 1)
        }
        
        return color
    }
}
