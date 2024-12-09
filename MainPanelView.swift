import SwiftUI

struct MainPanelView: View {
    @Binding var selectedTab: String
    @Binding var tabs: [String]
    @Binding var isSplitView: Bool
    @Binding var leftPanelWidth: CGFloat // Binding to adjust the left panel width

    var body: some View {
        VStack {
            HStack {
                Button("Tab 1") {
                    addTab("Tab 1")
                }
                Button("Tab 2") {
                    addTab("Tab 2")
                }
            }
            .padding()

            // Display tabs in split screen if more than one tab is selected
            if isSplitView && tabs.count > 1 {
                HStack(spacing: 0) {
                    // Left panel (first tab)
                    VStack {
                        Text("This is \(tabs[0])")
                            .font(.largeTitle)
                            .padding()
                        
                        Button(action: {
                            closeTab(tabs[0])
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                                .padding(5)
                        }
                    }
                    .frame(width: leftPanelWidth)
                    .background(Color(UIColor.systemGray6))
                    
                    // Divider between panels
                    Divider()
                        .frame(width: 1)
                        .background(Color.gray)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let newWidth = leftPanelWidth + value.translation.width
                                    if newWidth > 100 && newWidth < 600 {
                                        leftPanelWidth = newWidth
                                    }
                                }
                        )
                    
                    // Right panel (second tab)
                    VStack {
                        Text("This is \(tabs[1])")
                            .font(.largeTitle)
                            .padding()
                        
                        Button(action: {
                            closeTab(tabs[1])
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                                .padding(5)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemGray5))
                }
            } else {
                Text("This is \(tabs.first ?? selectedTab)")
                    .font(.largeTitle)
                    .padding()
            }
        }
    }

    private func addTab(_ tab: String) {
        if !tabs.contains(tab) {
            withAnimation {
                tabs.append(tab)
                isSplitView = true
            }
        }
    }

    private func closeTab(_ tab: String) {
        if let index = tabs.firstIndex(of: tab) {
            withAnimation {
                tabs.remove(at: index)
                if tabs.count <= 1 {
                    isSplitView = false
                }
            }
        }
    }
}

struct MainPanelView_Previews: PreviewProvider {
    static var previews: some View {
        MainPanelView(selectedTab: .constant("Tab 1"), tabs: .constant(["Tab 1"]), isSplitView: .constant(false), leftPanelWidth: .constant(200))
    }
}
