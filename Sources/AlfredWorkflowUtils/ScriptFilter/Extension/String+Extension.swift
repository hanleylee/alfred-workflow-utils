//
//  String+Extension.swift
//  alfred-workflow-utils
//
//  Created by Hanley Lee on 2024/12/14.
//

import AppKit
import Foundation

extension String {
    func fixedWidthContent(_ fixedWidth: CGFloat, font: NSFont, fillChar: String = " ", ellipsisChar: String = "…") -> String {
        let textSize = self.size(withAttributes: [.font: font])

        if textSize.width < fixedWidth {
            let spaceWidth = " ".size(withAttributes: [.font: font]).width
            let remainingWidth = fixedWidth - textSize.width
            let numberOfSpaces = Int(remainingWidth / spaceWidth)
            let paddedText = self + String(repeating: " ", count: numberOfSpaces)
            return paddedText
        }

        var truncatedText = self
        while truncatedText.count > 0 {
            let finalText = truncatedText + "…" // 在末尾加上省略号
            let textSize = finalText.size(withAttributes: [.font: font])
            if textSize.width < fixedWidth {
                return finalText
            }
            truncatedText.removeLast() // 移除最后一个字符，继续尝试
        }

        return "…" // 如果一个字符都放不下，则返回一个省略号
    }
}
