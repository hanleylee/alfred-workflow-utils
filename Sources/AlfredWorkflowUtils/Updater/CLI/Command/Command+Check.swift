//
//  File.swift
//
//
//  Created by Hanley Lee on 2024/11/26.
//

import AlfredWorkflowUpdaterCore
import ArgumentParser
import Foundation

struct CheckCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(commandName: "check", abstract: "Check if there is updated release in github.", discussion: "")
    @OptionGroup()
    var options: Command.Options

    @Option(help: ArgumentHelp("How long the cache will be expire"))
    var maxCacheAge: Int = .init(ProcessInfo.processInfo.environment["ALFRED_WORKFLOW_UPDATER_MAX_CACHE_AGE"] ?? "") ?? 1440

    func validate() throws {
        try options.validate()
    }

    func run() async throws {
        let updater = Updater(githubRepo: options.repo, workflowAssetName: options.workflowAssetName)
        let release = try await updater.check(maxCacheAge: maxCacheAge)
        print(release)
    }
}
