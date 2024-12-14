//
//  AlfredConst.swift
//  alfred-workflow-utils
//
//  Created by Hanley Lee on 2024/12/10.
//

import Foundation

/**
 ref: https://www.alfredapp.com/help/workflows/script-environment-variables/

 Example:
 
 "alfred_preferences" = "/Users/Crayons/Dropbox/Alfred/Alfred.alfredpreferences";
 "alfred_preferences_localhash" = adbd4f66bc3ae8493832af61a41ee609b20d8705;
 "alfred_theme" = "alfred.theme.yosemite";
 "alfred_theme_background" = "rgba(255,255,255,0.98)";
 "alfred_theme_subtext" = "3";
 "alfred_version" = "5.0";
 "alfred_version_build" = "2058";
 "alfred_workflow_bundleid" = "com.alfredapp.googlesuggest";
 "alfred_workflow_cache" = "/Users/Crayons/Library/Caches/com.runningwithcrayons.Alfred/Workflow Data/com.alfredapp.googlesuggest";
 "alfred_workflow_data" = "/Users/Crayons/Library/Application Support/Alfred/Workflow Data/com.alfredapp.googlesuggest";
 "alfred_workflow_name" = "Google Suggest";
 "alfred_workflow_version" = "1.7";
 "alfred_workflow_uid" = "user.workflow.B0AC54EC-601C-479A-9428-01F9FD732959";
 "alfred_debug" = 1;
 */
import AppKit

public struct AlfredConst {
    private init() {}

    public static let preferencesFolder = ProcessInfo.processInfo.environment["alfred_preferences"]
    public static let preferencesLocalHash = ProcessInfo.processInfo.environment["alfred_preferences_localhash"]
    public static let theme = ProcessInfo.processInfo.environment["alfred_theme"]
    public static let themeBackground = ProcessInfo.processInfo.environment["alfred_theme_background"]
    public static let themeSubtext = ProcessInfo.processInfo.environment["alfred_theme_subtext"]
    public static let version = ProcessInfo.processInfo.environment["alfred_version"]
    public static let versionBuild = ProcessInfo.processInfo.environment["alfred_version_build"]
    public static let workflowBundleID = ProcessInfo.processInfo.environment["alfred_workflow_bundleid"]
    public static let workflowCache = ProcessInfo.processInfo.environment["alfred_workflow_cache"]
    public static let workflowData = ProcessInfo.processInfo.environment["alfred_workflow_data"]
    public static let workflowName = ProcessInfo.processInfo.environment["alfred_workflow_name"]
    public static let workflowVersion = ProcessInfo.processInfo.environment["alfred_workflow_version"]
    public static let workflowUID = ProcessInfo.processInfo.environment["alfred_workflow_uid"]
    public static let debug = ProcessInfo.processInfo.environment["alfred_debug"]
    
    public static let ALFRED_BUNDLE_ID = "com.runningwithcrayons.Alfred"
    public static var ALFRED_INSTALL_URL: URL? { NSWorkspace.shared.urlForApplication(withBundleIdentifier: ALFRED_BUNDLE_ID) }
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

