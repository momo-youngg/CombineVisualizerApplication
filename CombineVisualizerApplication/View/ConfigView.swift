//
//  ConfigView.swift
//  CombineVisualizerApplication
//
//  Created by momo on 2023/05/21.
//

import SwiftUI

struct ConfigView: View {
    @State private var portText: String = String(CombineVisualizerServer.shared.port)
    @Binding var showPortApplyAlert: Bool
    @Binding var showResetAlert: Bool
    
    var body: some View {
        HStack {
            Text("Port:")
            TextField("", text: self.$portText)
                .frame(width: 50)
            Button {
                guard let portInt = UInt(self.portText) else {
                    return
                }
                CombineVisualizerServer.shared.port = portInt
                CombineVisualizerServer.shared.restart()
                showPortApplyAlert = true
            } label: {
                Text("apply")
            }
            Spacer()
            Button {
                CombineManager.shared.reset()
                showResetAlert = true
            } label: {
                Text("Reset")
            }
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView(
            showPortApplyAlert: Binding(projectedValue: .constant(false)),
            showResetAlert: Binding(projectedValue: .constant(false))
        )
    }
}
