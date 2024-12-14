//
//  AlfredTheme.swift
//  alfred-workflow-utils
//
//  Created by Hanley Lee on 2024/12/14.
//

import AppKit

public struct AlfredTheme: Codable {
    public struct Theme: Codable {
        public struct TextItem: Codable {
            public let font: String
            public let size: Int
            public let color: String
            public let colorSelected: String
        }

        public struct ResultItem: Codable {
            public let textSpacing: Int
            public let text: TextItem
            public let subtext: TextItem
            public let shortcut: TextItem
            public let backgroundSelected: String
            public let iconPaddingHorizontal: Int
            public let paddingVertical: Int
            public let iconSize: Int
        }

        public struct WindowItem: Codable {
            public let color: String
            public let width: Int
            public let borderPadding: Int
            public let borderColor: String
            public let blur: Int
            public let roundness: Int
            public let paddingHorizontal: Int
            public let paddingVertical: Int
        }

        public let result: ResultItem
        public let window: WindowItem
    }

    public let theme: Theme
    
    enum CodingKeys: String, CodingKey {
        case theme = "alfredtheme"
    }
}

public class AlfredManager {
    public static let shared = AlfredManager()
    public private(set) var currentTheme: AlfredTheme?

    private init() {
        currentTheme = getTheme()
    }
}

extension AlfredManager {
    private func getTheme() -> AlfredTheme? {
        guard let themeID = AlfredConst.theme else { return nil }
        let configPath: URL?
        if themeID.contains("theme.custom.") {
            guard let preferencesFolder = AlfredConst.preferencesFolder else { return nil }
            let themeName = themeID.replacingOccurrences(of: "theme.custom.", with: "")
            configPath = URL(filePath: preferencesFolder).appending(path: "/themes/theme.custom.\(themeName)/theme.json")
        } else if themeID.contains("theme.bundled.") {
            let themeName = themeID.replacingOccurrences(of: "theme.bundled.", with: "")
            // FIXME: the path of config file is wrong!
            configPath = AlfredConst.ALFRED_INSTALL_URL?.appending(path: "/Contents/Frameworks/Alfred Framework.framework/Versions/A/Resources/\(themeID).alfredappearence")
        } else {
            return nil
        }
        AlfredUtils.log("configPath: \(configPath?.absoluteString)")
        guard let configPath else { return nil }

        guard let fileData = try? Data(contentsOf: configPath) else {
            AlfredUtils.log("read data fail: \(configPath)")
            return nil
        }
        AlfredUtils.log("fileData: \(fileData.hashValue)")
        do {
            let theme = try JSONDecoder().decode(AlfredTheme.self, from: fileData)
            AlfredUtils.log("theme: \(theme)")
            return theme
        } catch {
            AlfredUtils.log(error.localizedDescription)
            return nil
        }

    }
}
