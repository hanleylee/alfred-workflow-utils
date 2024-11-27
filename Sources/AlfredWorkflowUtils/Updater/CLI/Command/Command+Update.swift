//
//  File.swift
//
//
//  Created by Hanley Lee on 2024/11/26.
//

import AlfredWorkflowUpdaterCore
import ArgumentParser
import Foundation

struct UpdateCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(commandName: "update", abstract: "Download and update to the latest version.", discussion: "")
    @OptionGroup()
    var options: Command.Options

    func validate() throws {
        try options.validate()
    }

    func run() async throws {
        let updater = Updater(githubRepo: options.repo, workflowAssetName: options.workflowAssetName)
        try await updater.updateToLatest()
    }
}
