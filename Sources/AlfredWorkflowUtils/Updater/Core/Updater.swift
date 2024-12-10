//
//  File.swift
//
//
//  Created by Hanley Lee on 2024/11/26.
//

import Foundation
import AlfredCore

public class Updater {
    private let githubRepo: String
    private let workflowAssetName: String

    @AppStorageCodable("LATEST_RELEASE_INFO", store: CommonTools.sharedUserDefaults)
    public private(set) var latestReleaseInfo: GitHubRelease?

    @AppStorageCodable("LAST_CHECKED_TIME", store: CommonTools.sharedUserDefaults)
    private var lastCheckedTime: Date?

    public init(githubRepo: String, workflowAssetName: String) {
        self.githubRepo = githubRepo
        self.workflowAssetName = workflowAssetName
    }

    public func check(maxCacheAge: Int) async throws -> GitHubRelease? {
        if let latestReleaseInfo, !enoughTimeHasElapsed(maxCacheAge: maxCacheAge) {
            // use cached info if it exist, and is not expire
            return latestReleaseInfo
        } else {
            guard let release = try await getLatestRelease(for: githubRepo) else { return nil }
            latestReleaseInfo = release
            lastCheckedTime = Date()
            return release
        }
    }

    public func downloadLatestRelease() async throws {
        guard let release = try await check(maxCacheAge: 0) else { return }
        guard let downloadURL = release.assets.first(where: { $0.name == self.workflowAssetName })?.browserDownloadURL else { return }

        let destinationURL = try await download(fileURL: downloadURL)
        try open(args: ["-R", destinationURL.path])
    }

    public func openLatestReleasePage() async throws {
        guard let release = try await check(maxCacheAge: 0) else { return }

        try? open(args: [release.htmlUrl])
    }

    public func updateToLatest() async throws {
        guard let release = try await check(maxCacheAge: 0) else { return }

        if AlfredConst.workflowVersion?.compare(release.tagName, options: .numeric) == .orderedAscending {
            // ascending, newer version exist
            guard let downloadURL = release.assets.first(where: { $0.name == self.workflowAssetName })?.browserDownloadURL else {
                print("Download url not found!")
                return
            }
            let destinationURL = try await download(fileURL: downloadURL)
            try? open(args: [destinationURL.path])
        } else {
            print("Current version is up-to-date")
            return
        }
    }
}

extension Updater {
    private func enoughTimeHasElapsed(maxCacheAge minutes: Int) -> Bool {
        guard let lastCheckedTime else { return true }

        guard let thresholdDate = Calendar.current.date(byAdding: .minute, value: minutes, to: lastCheckedTime) else { return true }
        let now = Date()

        return now > thresholdDate ? true : false
    }

    private func getLatestRelease(for gitHubRepository: String) async throws -> GitHubRelease? {
        let latestReleaseURL = "https://api.github.com/repos/\(gitHubRepository)/releases/latest"

        guard let url = URL(string: latestReleaseURL) else {
            print("Invalid URL")
            return nil
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let release = try JSONDecoder().decode(GitHubRelease.self, from: data)

        guard release.assets.contains(where: { $0.name == self.workflowAssetName }) else {
            print("Failed to find matching asset")
            return nil
        }

        return release
    }

    @discardableResult
    private func download(fileURL: String, to destinationDir: URL? = nil) async throws -> URL {
        guard let url = URL(string: fileURL) else { throw URLError(.badURL) }

        // 使用 download(from:) 下载文件到临时目录
        let (location, _) = try await URLSession.shared.download(from: url)
        let destinationDir = try destinationDir ?? FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let destinationFile = destinationDir.appending(path: workflowAssetName)

        // 将文件从临时位置移动到目标位置
        if FileManager.default.fileExists(atPath: destinationFile.path) {
            try FileManager.default.removeItem(at: destinationFile)
        }
        try FileManager.default.moveItem(at: location, to: destinationFile)

        return destinationFile
    }

    private func open(args: [String]) throws {
        let task = Process()

        task.executableURL = URL(fileURLWithPath: "/usr/bin/open")
        task.arguments = args

        try task.run()
    }

    private func revealFileInFinder(item: String) throws {}
}
