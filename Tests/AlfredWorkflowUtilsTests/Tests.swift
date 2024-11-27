//
//  File.swift
//  
//
//  Created by Hanley Lee on 2024/11/26.
//

import Foundation
import AlfredWorkflowScriptFilter
import XCTest

class Test1: XCTestCase {
    override class func setUp() {

    }

    override class func tearDown() {
    }

    func testA() {
        ScriptFilter.item(
            Item(title: "title")
                .subtitle("subtitle")
        )
        print(ScriptFilter.output())

    }
}
