//
//  GUIUpdater.swift
//  alfred-workflow-utils
//
//  Created by Hanley Lee on 2024/11/27.
//

import AppKit

@MainActor
class GUIUpdater {
    var delegate: AppDelegate?
    func run() {
        let app = NSApplication.shared
        
        // 创建主菜单
        let mainMenu = NSMenu()
        
        // 第一列菜单
        let firstMenuItem = NSMenuItem(title: "App", action: nil, keyEquivalent: "")
        let appSubmenu = NSMenu()
        let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate), keyEquivalent: "q")
        appSubmenu.addItem(quitMenuItem)
        let checkUpdateMenuItem = NSMenuItem(title: "Check for Updates", action: #selector(checkForUpdates), keyEquivalent: "")
        checkUpdateMenuItem.target = self // 确保目标是当前类实例
        appSubmenu.addItem(checkUpdateMenuItem)
        firstMenuItem.submenu = appSubmenu
        mainMenu.addItem(firstMenuItem)
        
        // 第二列菜单
        let secondMenuItem = NSMenuItem(title: "Actions", action: nil, keyEquivalent: "")
        let actionSubmenu = NSMenu()
        let testItem1 = NSMenuItem(title: "Test1", action: #selector(checkForUpdates), keyEquivalent: "")
        actionSubmenu.addItem(testItem1)
        let testItem2 = NSMenuItem(title: "Test2", action: #selector(checkForUpdates), keyEquivalent: "")
        actionSubmenu.addItem(testItem2)
        secondMenuItem.submenu = actionSubmenu
        mainMenu.addItem(secondMenuItem)
        
        // 设置主菜单
        app.mainMenu = mainMenu
        
        // 设置应用代理
        delegate = AppDelegate()
        app.delegate = delegate
        app.setActivationPolicy(.regular)
        app.run()
    }
    
    @objc func checkForUpdates() {
        print(123123)
    }
}
