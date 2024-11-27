//
//  File.swift
//
//
//  Created by Hanley Lee on 2024/11/26.
//

import ArgumentParser
import Foundation

struct Command: AsyncParsableCommand {
    @OptionGroup()
    var options: Options

    static let configuration = CommandConfiguration(
        commandName: "alfred-workflow-updater",
        abstract: "Tool used for update Alfred Workflow",
        discussion: "",
        subcommands: [
            CheckCommand.self,
            DownloadCommand.self,
            OpenCommand.self,
            UpdateCommand.self,
        ]
    )

    func run() async throws {
        print("Main command run!")
    }
}

extension Command {
    struct Options: ParsableArguments {
        @Option(help: ArgumentHelp("The repo of the Alfred Workflow"))
        var repo: String = ProcessInfo.processInfo.environment["ALFRED_WORKFLOW_UPDATER_REPO"] ?? ""

        @Option(help: ArgumentHelp("The asset name of the workflow on GitHub"))
        var workflowAssetName: String = ProcessInfo.processInfo.environment["ALFRED_WORKFLOW_UPDATER_ASSET_NAME"] ?? ""

        func validate() throws {
            if repo.isEmpty {
                throw ValidationError("The 'repo' parameter must be provided either as an argument or through the 'ALFRED_WORKFLOW_UPDATER_REPO' environment variable.")
            }
            if workflowAssetName.isEmpty {
                throw ValidationError("The 'workflowAssetName' parameter must be provided either as an argument or through the 'ALFRED_WORKFLOW_UPDATER_ASSET_NAME' environment variable.")
            }
        }
    }
}
