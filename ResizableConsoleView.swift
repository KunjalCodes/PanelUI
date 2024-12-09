import SwiftUI

struct ResizableConsoleView: View {
    @Binding var consoleHeight: CGFloat
    @State private var logs = ["Build Succeeded", "Error: Missing File"]

    var body: some View {
        VStack {
            HStack {
                Text("Console")
                    .font(.headline)
                Spacer()
                Button("Clear") {
                    logs.removeAll()
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))

            Divider()

            ScrollView {
                ForEach(logs, id: \.self) { log in
                    Text(log)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
            }
            .frame(height: consoleHeight)
            .background(Color(UIColor.systemGroupedBackground))
            .gesture(DragGesture()
                        .onChanged { value in
                            consoleHeight -= value.translation.height
                        })
        }
        .transition(.move(edge: .bottom))
    }
}

