//
//  WorkflowUtils.swift
//  alfred-workflow-utils
//
//  Created by Hanley Lee on 2024/12/14.
//
import AppKit
import AlfredCore

public struct WorkflowUtils {
    
    public static func alignedText(left: String, right: String, component: ItemVisibleComponent) -> String {
        let fullStr = "\(left)    \(right)"
        guard let currentTheme = AlfredManager.shared.currentTheme else { return fullStr }
//        let fontName = currentTheme.theme.result.text.font
        let fontSize: Int
        switch component {
        case .title:
            fontSize = currentTheme.theme.result.text.size
        case .subtitle:
            fontSize = currentTheme.theme.result.subtext.size
        }
        //        guard let font = NSFont(name: fontName, size: CGFloat(fontSize)) else { return fullStr }
        let font = NSFont.systemFont(ofSize: CGFloat(fontSize))
        AlfredUtils.log("alfred font: \(font)")
        let windowWidth = currentTheme.theme.window.width

        let rightWidth = right.size(withAttributes: [.font: font]).width
        let leftWidth = (CGFloat(windowWidth) - rightWidth) * 0.85
        let leftTruncatedText = left.fixedWidthContent(leftWidth, font: font)

        return "\(leftTruncatedText)\(right)"
    }
}
