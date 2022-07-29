//
//  TreeCollection.swift
//  producTreevity
//
//  Created by Jessica Geofanie on 25/07/22.
//

import SwiftUI


struct TreeCollection: View {
    @Environment(\.dismiss) var dismiss
    @State private var willMoveToDashboard = false
    @StateObject var vm = CoreDataViewModel()
    @State var index = 0
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView{
            ZStack{
                Color(red: 0.98, green: 0.99, blue: 0.84).ignoresSafeArea()
                
                if vm.projects.count == 0{
                    Text("No Project Tree Created")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .navigationBarTitle("Tree Collection")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBar(backgroundColor: Color(red: 0.64, green: 0.70, blue: 0.54), titleColor: .black)
                        .navigationBarItems(leading: HStack {
                            Button {
                                dismiss()
                                
                            } label: {
                                HStack{
                                    Image(systemName: "chevron.backward")
                                    Text("Back")
                                }
                            }
                            
                        })
                }
                else {
                    ScrollView {
                        LazyVGrid(columns: gridItemLayout, spacing: 8){
                            ForEach(0..<vm.projects.count, id: \.self) { idx in
                                Button {
                                    willMoveToDashboard = true
                                    print("\(idx) tapped")
                                    index = idx
                                } label: {
                                    VStack(spacing: 8.0){
                                        Image("\(vm.projects[idx].projectImageType ?? "")")
                                            .resizable()
                                            .frame(width: 101, height: 108)
                                        Text("\(vm.projects[idx].projectName ?? "")")
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                        Text("\(vm.projects[idx].finishedTask)/\(vm.projects[idx].task.count) Task Finished")
                                            .foregroundColor(Color.orange)
                                            .lineLimit(1)
                                            .font(.system(size: 13))
                                    }
                                }

                                

                            }
                        }
                        .navigationBarTitle("Tree Collection")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBar(backgroundColor: Color(red: 0.64, green: 0.70, blue: 0.54), titleColor: .black)
                        .navigationBarItems(leading: HStack {
                            Button {
                                dismiss()
                            } label: {
                                HStack{
                                    Image(systemName: "chevron.backward")
                                    Text("Back")
                                }
                            }
                            
                    })
                    }
                    .padding(.all, 16.0)
                }
//                Button {
//                    print(vm.projects)
//                    print(vm.projects.count)
//                } label: {
//                    Text("test")
//                }

            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigate(to: ContentView(idx: index), when: $willMoveToDashboard)
    }
}


struct TreeProgressView:View{
    @Binding var imageName:String
    @Binding var projectName:String
    var body: some View{
        VStack(spacing: 8.0){
            Image("pink-tree")
                .resizable()
                .frame(width: 101, height: 108)
            Text("Learn Core Data")
                .multilineTextAlignment(.center)
                .lineLimit(2)
            Text("100% Finished")
                .foregroundColor(Color.orange)
                .lineLimit(1)
                .font(.system(size: 13))
        }
    }
}
struct TreeCollection_Previews: PreviewProvider {
    static var previews: some View {
        TreeCollection()
    }
}

//https://betterprogramming.pub/the-swiftui-equivalents-to-uicollectionview-60415e3c1bbe

