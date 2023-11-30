//
//  UIColor.swift
//  Tracker
//
//  Created by Kirill Gontsov on 10.11.2023.
//

import UIKit

extension UIColor {
    static var randomColor: UIColor {
        let colorCodes: [String] = ["#FD4C49", "#FF881E", "#007BFA", "#6E44FE", "#33CF69", "#E66DD4", "#F9D4D4", "#34A7FE", "#46E69D", "#35347C", "#FF674D", "#FF99CC", "#F6C48B", "#7994F5", "#832CF1", "#AD56DA", "#8D72E6", "#2FD058"]
        let randomIndex = Int.random(in: 0..<colorCodes.count)
        let hexString = colorCodes[randomIndex]

        var rgb: UInt64 = 0
        Scanner(string: hexString.replacingOccurrences(of: "#", with: "")).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
