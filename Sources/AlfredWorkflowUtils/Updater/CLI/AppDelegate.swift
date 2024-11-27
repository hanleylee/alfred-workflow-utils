//
//  AppDelegate.swift
//  alfred-workflow-utils
//
//  Created by Hanley Lee on 2024/11/27.
//
import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var window: NSWindow?
    
    override init () {}

    func applicationDidFinishLaunching(_ notification: Notification) {
        if window == nil {
            let updateView = UpdateView()
            let hostingController = NSHostingController(rootView: updateView)

            let newWindow = NSWindow(contentViewController: hostingController)
            newWindow.styleMask = [.titled, .closable]
            newWindow.title = "Update"
            newWindow.setContentSize(NSSize(width: 300, height: 200))
            newWindow.center()
            newWindow.makeKeyAndOrderFront(nil)

            window = newWindow
        }
    }
}
