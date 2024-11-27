//
//  UpdateView.swift
//  alfred-workflow-utils
//
//  Created by Hanley Lee on 2024/11/27.
//

import SwiftUI

struct UpdateView: View {
    @State private var progress: Double = 0.0 // 用于更新进度条
    @State private var isChecking: Bool = true // 表示是否正在检查更新

    var body: some View {
        VStack(spacing: 20) {
            Text(isChecking ? "Checking for Updates..." : "Update Completed")
                .font(.headline)
                .padding()

            if isChecking {
                ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(width: 200)
            } else {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
            }

            Button(isChecking ? "Cancel" : "Close") {
                NSApplication.shared.keyWindow?.close()
            }
            .padding()
        }
        .padding(30)
        .frame(width: 300, height: 200)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.windowBackgroundColor))
                .shadow(radius: 10)
        )
        .onAppear {
            simulateProgress()
        }
    }

    private func simulateProgress() {
        // 模拟检查更新的进度
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.progress < 1.0 {
                self.progress += 0.05
            } else {
                timer.invalidate()
                self.isChecking = false
            }
        }
    }
}
