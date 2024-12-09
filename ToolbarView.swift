import SwiftUI

struct ToolbarView: View {
    @Binding var isSidebarVisible: Bool
    @Binding var isConsoleVisible: Bool

    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    isSidebarVisible.toggle()
                }
            }) {
                Label("Toggle Sidebar", systemImage: "sidebar.left")
            }

            Spacer()

            Button(action: {
                withAnimation {
                    isConsoleVisible.toggle()
                }
            }) {
                Label("Toggle Console", systemImage: "rectangle.and.text.magnifyingglass")
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
    }
}

