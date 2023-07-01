//
//  CombineView.swift
//  CombineVisualizerApplication
//
//  Created by momo on 2023/05/18.
//

import SwiftUI

struct CombineView: View {
    @State var combineGroups: [CombineGroup] = []
    @State var showPortApplyAlert: Bool = false
    @State var showResetAlert: Bool = false
    
    @State var combineGroupPageIndex: Int = 0
    
    private var maxIndex: Int {
        if combineGroups.isEmpty {
            return 0
        }
        return combineGroups.count - 1
    }
    
    private var currentCombineGroup: CombineGroup? {
        if combineGroups.count > combineGroupPageIndex {
            return combineGroups[combineGroupPageIndex]
        }
        return nil
    }
    
    private var canGoNext: Bool {
        combineGroupPageIndex < combineGroups.count - 1
    }
    
    private var canGoPrev: Bool {
        combineGroupPageIndex > 0
    }
    
    var body: some View {
        VStack(spacing: Constants.configSpacing) {
            ZStack {
                ConfigView(
                    showPortApplyAlert: $showPortApplyAlert,
                    showResetAlert: $showResetAlert,
                    combineGroupPageIndex: $combineGroupPageIndex
                )
                navigationView
            }
            if let currentCombineGroup = currentCombineGroup {
                CombineElementGroupView(group: currentCombineGroup)
            }
            Spacer()
        }
        .padding(Constants.edgeInsets)
        .onReceive(CombineManager.shared.combineGroupsSubject) { combineGroups in
            self.combineGroups = combineGroups
        }
        .alert(
            Text("Port is now \(CombineVisualizerServer.shared.port)"),
            isPresented: $showPortApplyAlert
        ) {
            // do nothing
        }
        .alert(
            Text("Reset completed"),
            isPresented: $showResetAlert
        ) {
            // do nothing
        }
    }
    
    private var navigationView: some View {
        HStack(spacing: Constants.configSpacing) {
            Spacer()
            Button {
                combineGroupPageIndex -= 1
            } label: {
                Image(systemName: "arrow.left")
                    .padding()
            }
            .disabled(canGoPrev == false)
            Button {
                combineGroupPageIndex += 1
            } label: {
                Image(systemName: "arrow.right")
                    .padding()
            }
            .disabled(canGoNext == false)
            Spacer()
        }
    }
}

extension CombineView {
    enum Constants {
        static let configSpacing: CGFloat = 10
        static let groupSpacing: CGFloat = 10
        static let edgeInsets: EdgeInsets = EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        static let dividerInsets: EdgeInsets = EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
    }
}

struct CombineView_Previews: PreviewProvider {
    static var previews: some View {
        CombineView(combineGroups: [
            CombineGroup(
                trid: UUID(),
                elements: [
                    CombineElement(
                        uuid: UUID(),
                        elementType: .subject,
                        typeName: "Combine.PassthroughSubject",
                        edges: [
                            Edges(
                                sequence: 2,
                                queue: "com.apple.root.utility-qos",
                                thread: "2",
                                method: .receiveSubscriber("SubscribeOn")
                            ),
                            Edges(
                                sequence: 9,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .sendOutput
                            ),
                            Edges(
                                sequence: 12,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .sendOutput
                            ),
                            Edges(
                                sequence: 115,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .sendOutput
                            )
                        ]
                    ),
                    CombineElement(
                        uuid: UUID(),
                        elementType: .publisher,
                        typeName: "ReceiveOn",
                        edges: [
                            Edges(
                                sequence: 0,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .receiveSubscriber("Sink")
                            )
                        ]
                    ),
                    CombineElement(
                        uuid: UUID(),
                        elementType: .publisher,
                        typeName: "SubscribeOn",
                        edges: [
                            Edges(
                                sequence: 1,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .receiveSubscriber("ReceiveOn")
                            )
                        ]
                    ),
                    CombineElement(
                        uuid: UUID(),
                        elementType: .subscription,
                        typeName: "ReceiveOn",
                        edges: [
                            Edges(
                                sequence: 6,
                                queue: "com.apple.root.utility-qos",
                                thread: "2",
                                method: .request
                            ),
                            Edges(
                                sequence: 21,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .cancel
                            )
                        ]
                    ),
                    CombineElement(
                        uuid: UUID(),
                        elementType: .subscription,
                        typeName: "SubscribeOn",
                        edges: [
                            Edges(
                                sequence: 7,
                                queue: "com.apple.root.utility-qos",
                                thread: "2",
                                method: .request
                            ),
                            Edges(
                                sequence: 22,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .cancel
                            )
                        ]
                    ),
                    CombineElement(
                        uuid: UUID(),
                        elementType: .subscription,
                        typeName: "PassthroughSubject",
                        edges: [
                            Edges(
                                sequence: 8,
                                queue: "com.apple.root.utility-qos",
                                thread: "3",
                                method: .request
                            ),
                            Edges(
                                sequence: 23,
                                queue: "com.apple.root.utility-qos",
                                thread: "2",
                                method: .cancel
                            )
                        ]
                    ),
                    CombineElement(
                        uuid: UUID(),
                        elementType: .subscriber,
                        typeName: "SubscribeOn",
                        edges: [
                            Edges(
                                sequence: 3,
                                queue: "com.apple.root.utility-qos",
                                thread: "2",
                                method: .receiveSubscription("PassthroughSubject")
                            ),
                            Edges(
                                sequence: 10,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .receiveInput
                            ),
                            Edges(
                                sequence: 13,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .receiveInput
                            ),
                            Edges(
                                sequence: 16,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .receiveInput
                            )
                        ]
                    ),
                    CombineElement(
                        uuid: UUID(),
                        elementType: .subscriber,
                        typeName: "ReceiveOn",
                        edges: [
                            Edges(
                                sequence: 4,
                                queue: "com.apple.root.utility-qos",
                                thread: "2",
                                method: .receiveSubscription("SubscribeOn")
                            ),
                            Edges(
                                sequence: 11,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .receiveInput
                            ),
                            Edges(
                                sequence: 14,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .receiveInput
                            ),
                            Edges(
                                sequence: 18,
                                queue: "com.apple.main-thread",
                                thread: "1",
                                method: .receiveInput
                            )
                        ]
                    ),
                    CombineElement(
                        uuid: UUID(),
                        elementType: .subscriber,
                        typeName: "Sink",
                        edges: [
                            Edges(
                                sequence: 5,
                                queue: "com.apple.root.utility-qos",
                                thread: "2",
                                method: .receiveSubscription("ReceiveOn")
                            ),
                            Edges(
                                sequence: 17,
                                queue: "com.apple.root.background-qos",
                                thread: "3",
                                method: .receiveInput
                            ),
                            Edges(
                                sequence: 19,
                                queue: "com.apple.root.background-qos",
                                thread: "3",
                                method: .receiveInput
                            ),
                            Edges(
                                sequence: 20,
                                queue: "com.apple.root.background-qos",
                                thread: "2",
                                method: .receiveInput
                            )
                        ]
                    )
                ]
            )
        ])
    }
}
