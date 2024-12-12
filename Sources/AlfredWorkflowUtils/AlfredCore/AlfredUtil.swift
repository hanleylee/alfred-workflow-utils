//
//  File.swift
//
//
//  Created by Hanley Lee on 2024/11/26.
//

import Foundation

public struct AlfredUtils {
    private init() {}
    public static func log(_ content: String) {
        if AlfredConst.version == nil { // outside Alfred environment
            print(content)
        } else { // inside Alfred environment
            if AlfredConst.debug != nil {
                fputs(content, stderr)
            }
        }
    }

    public static func output(_ content: String) {
        print(content)
    }

//    public static var currentVersion: String? {
//        let url = URL(fileURLWithPath: "\(AlfredConst.preferencesFolder)/workflows/\(AlfredConst.workflowUID)/info.plist")
//
//        if let workflowData = try? Data(contentsOf: url),
//           let info = try? PropertyListSerialization.propertyList(from: workflowData, options: [], format: nil) as? [String: Any],
//           let version = info["version"] as? String
//        {
//            return version
//        } else {
//            return nil
//        }
//    }
}
