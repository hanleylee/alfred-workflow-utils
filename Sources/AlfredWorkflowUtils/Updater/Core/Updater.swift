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
    /// Interval to check update on GitHub, in second
    private let checkInterval: TimeInterval

    @AppStorageCodable("LATEST_RELEASE_INFO", store: CommonTools.sharedUserDefaults)
    public private(set) var latestReleaseInfo: GitHubRelease?

    public init(githubRepo: String, workflowAssetName: String, checkInterval: TimeInterval = 60*60*24) {
        self.githubRepo = githubRepo
        self.workflowAssetName = workflowAssetName
        self.checkInterval = checkInterval
    }

    public func check() async throws -> GitHubRelease? {
        guard let release = try await requestLatestRelease(for: githubRepo) else { return nil }
        latestReleaseInfo = release
        return release
    }

    public func downloadLatestRelease() async throws {
        guard let release = try await check() else { return }
        guard let downloadURL = release.assets.first(where: { $0.name == self.workflowAssetName })?.browserDownloadURL else { return }

        let destinationURL = try await download(fileURL: downloadURL)
        try open(args: ["-R", destinationURL.path])
    }

    public func openLatestReleasePage() async throws {
        guard let release = try await check() else { return }

        try? open(args: [release.htmlUrl])
    }

    public func updateToLatest() async throws {
        guard let release = try await check() else { return }

        if AlfredConst.workflowVersion?.compare(release.tagName, options: .numeric) == .orderedAscending {
            // ascending, newer version exist
            guard let downloadURL = release.assets.first(where: { $0.name == self.workflowAssetName })?.browserDownloadURL else {
                AlfredUtils.log("Download url not found!")
                return
            }
            let destinationURL = try await download(fileURL: downloadURL)
            try? open(args: [destinationURL.path])
        } else {
            AlfredUtils.log("Current version is up-to-date")
            return
        }
    }
}

extension Updater {
    public func cacheValid() -> Bool {
        guard let lastCheckedTimestamp = self.latestReleaseInfo?.lastCheckedTimestamp else { return false }

        let endTimestamp =  checkInterval + lastCheckedTimestamp
        let now = Date.now.timeIntervalSince1970

        return now > endTimestamp ? false : true
    }

    private func requestLatestRelease(for gitHubRepository: String) async throws -> GitHubRelease? {
        let latestReleaseURL = "https://api.github.com/repos/\(gitHubRepository)/releases/latest"

        guard let url = URL(string: latestReleaseURL) else {
            AlfredUtils.log("Invalid URL")
            return nil
        }

//        URLCache.shared.removeAllCachedResponses()
//        var request = URLRequest(url: url)
        // 默认情况下使用协议中的约定, 可能会使用缓存, 这里可以强制每次都从服务器获取新数据
//        request.cachePolicy = .reloadIgnoringLocalCacheData
        let (data, _) = try await URLSession.shared.data(from: url)

        var release = try JSONDecoder().decode(GitHubRelease.self, from: data)
        release.lastCheckedTimestamp = Date.now.timeIntervalSince1970

        guard release.assets.contains(where: { $0.name == self.workflowAssetName }) else {
            AlfredUtils.log("Failed to find matching asset")
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
