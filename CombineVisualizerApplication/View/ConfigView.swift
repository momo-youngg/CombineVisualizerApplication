//
//  ConfigView.swift
//  CombineVisualizerApplication
//
//  Created by momo on 2023/05/21.
//

import SwiftUI

struct ConfigView: View {
    @State private var portText: String = String(CombineVisualizerServer.shared.port)
    
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
            } label: {
                Text("apply")
            }
            Spacer()
            Button {
                CombineManager.shared.reset()
            } label: {
                Text("Reset")
            }
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
