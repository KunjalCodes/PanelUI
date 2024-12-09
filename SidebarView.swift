import SwiftUI

struct SidebarView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Files")
                .font(.headline)
                .padding([.top, .horizontal])

            List {
                Text("File1.swift")
                Text("File2.swift")
                Text("Folder1")
            }
            .listStyle(SidebarListStyle())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.systemGray6))
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .frame(width: 250)
    }
}
