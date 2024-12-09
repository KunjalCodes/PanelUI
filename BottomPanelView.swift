import SwiftUI

struct BottomPanelView: View {
    @Binding var consoleHeight: CGFloat
    @State private var consoleMessages: String = "Build Succeeded\nError: Missing File"

    var body: some View {
        VStack(spacing: 0) {
            // Dragging handle for resizing
            Rectangle()
                .frame(height: 5)
                .foregroundColor(.gray)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Adjust height based on drag
                            consoleHeight = max(100, consoleHeight - value.translation.height)
                        }
                )
                .background(Color(UIColor.systemGray4))
                .onTapGesture {
                    // Optional: Add feedback for interaction if required
                }

            // Console content
            VStack(spacing: 0) {
                HStack {
                    Text("Console Output")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        consoleMessages = "" // Clear console messages
                    }) {
                        Label("Clear", systemImage: "trash")
                            .font(.footnote)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))

                ScrollView {
                    Text(consoleMessages.isEmpty ? "No messages." : consoleMessages)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .background(Color(UIColor.systemGray5))
            }
            .frame(height: consoleHeight)
            .background(Color(UIColor.systemGray6))
        }
    }
}

struct BottomPanelView_Previews: PreviewProvider {
    static var previews: some View {
        BottomPanelView(consoleHeight: .constant(200))
            .previewLayout(.sizeThatFits)
    }
}
