//
//  File.swift
//
//
//  Created by Hanley Lee on 2024/11/26.
//

import AppKit
import Foundation
import AlfredCore

public struct AlfredUtils {
    private init() {}
    public static func log(_ content: String) {
        if AlfredConst.version == nil { // outside Alfred environment
            fputs(content + "\n", stdout)
        } else { // inside Alfred environment
            if AlfredConst.debug != nil {
                fputs(content + "\n", stderr)
            }
        }
    }

    public static func output(_ content: String) {
        fputs(content + "\n", stdout)
    }
}

