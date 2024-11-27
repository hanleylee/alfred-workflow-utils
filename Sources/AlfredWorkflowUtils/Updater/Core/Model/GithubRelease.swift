//
//  File.swift
//
//
//  Created by Hanley Lee on 2024/11/26.
//

import Foundation

public struct GitHubRelease: Codable {
    public struct Asset: Codable {
        public let name: String
        public let browserDownloadURL: String

        enum CodingKeys: String, CodingKey {
            case name
            case browserDownloadURL = "browser_download_url"
        }
    }

    public let htmlUrl: String
    public let tagName: String
    public let assets: [Asset]

    enum CodingKeys: String, CodingKey {
        case htmlUrl = "html_url"
        case tagName = "tag_name"
        case assets
    }
}

/**
 ```json
 {
     "url": "https://api.github.com/repos/hanleylee/alfred-qsirch-workflow/releases/187147224",
     "assets_url": "https://api.github.com/repos/hanleylee/alfred-qsirch-workflow/releases/187147224/assets",
     "upload_url": "https://uploads.github.com/repos/hanleylee/alfred-qsirch-workflow/releases/187147224/assets{?name,label}",
     "html_url": "https://github.com/hanleylee/alfred-qsirch-workflow/releases/tag/0.0.3",
     "id": 187147224,
     "author": {
         "login": "hanleylee",
         "id": 35610874,
         "node_id": "MDQ6VXNlcjM1NjEwODc0",
         "avatar_url": "https://avatars.githubusercontent.com/u/35610874?v=4",
         "gravatar_id": "",
         "url": "https://api.github.com/users/hanleylee",
         "html_url": "https://github.com/hanleylee",
         "followers_url": "https://api.github.com/users/hanleylee/followers",
         "following_url": "https://api.github.com/users/hanleylee/following{/other_user}",
         "gists_url": "https://api.github.com/users/hanleylee/gists{/gist_id}",
         "starred_url": "https://api.github.com/users/hanleylee/starred{/owner}{/repo}",
         "subscriptions_url": "https://api.github.com/users/hanleylee/subscriptions",
         "organizations_url": "https://api.github.com/users/hanleylee/orgs",
         "repos_url": "https://api.github.com/users/hanleylee/repos",
         "events_url": "https://api.github.com/users/hanleylee/events{/privacy}",
         "received_events_url": "https://api.github.com/users/hanleylee/received_events",
         "type": "User",
         "user_view_type": "public",
         "site_admin": false
     },
     "node_id": "RE_kwDONTv7Is4LJ6PY",
     "tag_name": "0.0.3",
     "target_commitish": "main",
     "name": "0.0.3",
     "draft": false,
     "prerelease": false,
     "created_at": "2024-11-24T06:02:42Z",
     "published_at": "2024-11-24T06:04:39Z",
     "assets": [
         {
             "url": "https://api.github.com/repos/hanleylee/alfred-qsirch-workflow/releases/assets/208681433",
             "id": 208681433,
             "node_id": "RA_kwDONTv7Is4McDnZ",
             "name": "Qsirch.alfredworkflow",
             "label": null,
             "uploader": {
                 "login": "hanleylee",
                 "id": 35610874,
                 "node_id": "MDQ6VXNlcjM1NjEwODc0",
                 "avatar_url": "https://avatars.githubusercontent.com/u/35610874?v=4",
                 "gravatar_id": "",
                 "url": "https://api.github.com/users/hanleylee",
                 "html_url": "https://github.com/hanleylee",
                 "followers_url": "https://api.github.com/users/hanleylee/followers",
                 "following_url": "https://api.github.com/users/hanleylee/following{/other_user}",
                 "gists_url": "https://api.github.com/users/hanleylee/gists{/gist_id}",
                 "starred_url": "https://api.github.com/users/hanleylee/starred{/owner}{/repo}",
                 "subscriptions_url": "https://api.github.com/users/hanleylee/subscriptions",
                 "organizations_url": "https://api.github.com/users/hanleylee/orgs",
                 "repos_url": "https://api.github.com/users/hanleylee/repos",
                 "events_url": "https://api.github.com/users/hanleylee/events{/privacy}",
                 "received_events_url": "https://api.github.com/users/hanleylee/received_events",
                 "type": "User",
                 "user_view_type": "public",
                 "site_admin": false
             },
             "content_type": "application/octet-stream",
             "state": "uploaded",
             "size": 548675,
             "download_count": 1,
             "created_at": "2024-11-24T06:04:29Z",
             "updated_at": "2024-11-24T06:04:36Z",
             "browser_download_url": "https://github.com/hanleylee/alfred-qsirch-workflow/releases/download/0.0.3/Qsirch.alfredworkflow"
         }
     ],
     "tarball_url": "https://api.github.com/repos/hanleylee/alfred-qsirch-workflow/tarball/0.0.3",
     "zipball_url": "https://api.github.com/repos/hanleylee/alfred-qsirch-workflow/zipball/0.0.3",
     "body": "**Full Changelog**: https://github.com/hanleylee/alfred-qsirch-workflow/compare/0.0.2...0.0.3\r\n\r\nSupport various icon of result item"
 }
 ```
 */
