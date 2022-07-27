//
//  TreeCollection.swift
//  producTreevity
//
//  Created by Jessica Geofanie on 25/07/22.
//

import SwiftUI


struct TreeCollection: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(red: 0.98, green: 0.99, blue: 0.84).ignoresSafeArea()
                List(){
                    ForEach(0..<8) { _ in
                        HStack(spacing: 16.0) {
                            ForEach(0..<3) { _ in
                                TreeProgressView()
                            }
                        }
                        .listRowBackground(Color(red: 0.98, green: 0.99, blue: 0.84))
                        .listRowSeparator(.hidden)
                    }
                }
                .onAppear() {
                    UITableView.appearance().backgroundColor = UIColor(red: 0.98, green: 0.99, blue: 0.84, alpha: 1.00)
                    UITableViewCell.appearance().backgroundColor = UIColor(red: 0.98, green: 0.99, blue: 0.84, alpha: 1.00)
                    //                            }
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
            .navigationViewStyle(StackNavigationViewStyle())
        }
        
        //    var collectionView:some View{
        //        Text("collection View")
        //    }
        
        
    }
}


struct TreeProgressView:View{
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

