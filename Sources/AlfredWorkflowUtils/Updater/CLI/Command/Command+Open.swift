//
//  File.swift
//
//
//  Created by Hanley Lee on 2024/11/26.
//

import AlfredWorkflowUpdaterCore
import ArgumentParser
import Foundation

struct OpenCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(commandName: "open", abstract: "Open latest release page on GitHub", discussion: "")
    @OptionGroup()
    var options: Command.Options

    func validate() throws {
        try options.validate()
    }

    func run() async throws {
        let updater = Updater(githubRepo: options.repo, workflowAssetName: options.workflowAssetName)
        try await updater.openLatestReleasePage()
    }
}
