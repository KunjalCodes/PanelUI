import SwiftUI

struct ContentView: View {
    @State private var isSidebarVisible = false
    @State private var selectedTab = "Tab 1"
    @State private var isConsoleVisible = false
    @State private var consoleHeight: CGFloat = 200
    @State private var tabs: [String] = ["Tab 1"]
    @State private var isSplitView = false
    @State private var leftPanelWidth: CGFloat = 200
    @State private var dividerPosition: CGFloat = UIScreen.main.bounds.width / 2
    @State private var isDarkMode = false // State for dark mode

    var body: some View {
        VStack(spacing: 0) {
            // Toolbar at the top
            HStack {
                Button(action: {
                    withAnimation {
                        isSidebarVisible.toggle()
                    }
                }) {
                    Image(systemName: "sidebar.left")
                        .padding()
                        .foregroundColor(isDarkMode ? .white : .blue)
                }

                Spacer()

                Text("IDE Panels UI")
                    .font(.headline)
                    .foregroundColor(isDarkMode ? .white : .black)

                Spacer()

                // Console toggle button
                Button(action: {
                    withAnimation {
                        isConsoleVisible.toggle()
                    }
                }) {
                    Image(systemName: "terminal")
                        .padding()
                        .foregroundColor(isDarkMode ? .white : .blue)
                }

                // Add tab button
                Button(action: {
                    let newTab = "Tab \(tabs.count + 1)"
                    tabs.append(newTab)
                    isSplitView = tabs.count > 1
                }) {
                    Image(systemName: "plus.circle.fill")
                        .padding()
                        .foregroundColor(isDarkMode ? .white : .blue)
                }

                // Toggle dark mode button
                Button(action: {
                    isDarkMode.toggle()
                }) {
                    Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                        .padding()
                        .foregroundColor(isDarkMode ? .yellow : .blue)
                }
            }
            .background(isDarkMode ? Color.black : Color.gray.opacity(0.2))

            // Main content area
            HStack(spacing: 0) {
                if isSidebarVisible {
                    SidebarView()
                        .frame(width: 250)
                        .transition(.move(edge: .leading))
                }

                VStack(spacing: 0) {
                    if isSplitView {
                        // Resizable split view for tabs
                        HStack(spacing: 0) {
                            // Left Panel
                            VStack {
                                Text("This is \(tabs[0])")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                Button(action: {
                                    tabs.remove(at: 0)
                                    isSplitView = tabs.count > 1
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                        .padding(4)
                                }
                            }
                            .frame(width: dividerPosition)
                            .background(isDarkMode ? Color.gray.opacity(0.3) : Color.white)

                            // Divider with Drag Gesture
                            Rectangle()
                                .frame(width: 5)
                                .foregroundColor(isDarkMode ? .gray : .blue)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            let newWidth = dividerPosition + value.translation.width
                                            let screenWidth = UIScreen.main.bounds.width
                                            if newWidth > 100 && newWidth < screenWidth - 100 {
                                                dividerPosition = newWidth
                                            }
                                        }
                                )

                            // Right Panel
                            VStack {
                                Text("This is \(tabs[1])")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                Button(action: {
                                    tabs.remove(at: 1)
                                    isSplitView = tabs.count > 1
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                        .padding(4)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .background(isDarkMode ? Color.gray.opacity(0.3) : Color.white)
                        }
                    } else {
                        // Single tab view
                        Text("This is \(tabs.first ?? "Tab 1")")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(isDarkMode ? .white : .black)
                            .background(isDarkMode ? Color.gray.opacity(0.3) : Color.white)
                    }

                    if isConsoleVisible {
                        Divider()
                        BottomPanelView(consoleHeight: $consoleHeight)
                            .frame(maxWidth: .infinity)
                            .background(isDarkMode ? Color.black : Color.gray.opacity(0.1))
                            .transition(.move(edge: .bottom))
                    }
                }
            }
        }
        .background(isDarkMode ? Color.black : Color.white)
        .edgesIgnoringSafeArea(.bottom)
        .environment(\.colorScheme, isDarkMode ? .dark : .light) // Toggle environment color scheme
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 16")
    }
}
