//
//  Timeline.swift
//  producTreevity
//
//  Created by Jessica Geofanie on 25/07/22.
//

import SwiftUI

struct Timeline: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = CoreDataViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(red: 0.98, green: 0.99, blue: 0.84).ignoresSafeArea()
                if vm.projects.count == 0{
                    Text("There are no activities yet")
                        .font(.headline)
                        .fontWeight(.semibold)
                        
                }
                else {
                    ScrollView {
                        ForEach(0..<vm.projects.reversed().count, id: \.self) {
                            idx in
                            
                            VStack(alignment: .leading, spacing: 16.0){
                                VStack(alignment: .leading){
                                    Text(vm.projects.reversed()[idx].projectCreatedDate ?? "")
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                        .font(.system(size: 13))
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 16)
                                            .foregroundColor(Color(red: 0.90, green: 0.73, blue: 0.58))
                                            .frame(width: 357, height: 42, alignment: .center)
                                        HStack(){
                                            Text("\(vm.projects.reversed()[idx].projectName ?? "") Created")
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(1)
                                            Spacer()
                                        }
                                        .padding(.all, 8.0)
                                    }
                                }
                                Spacer()
                            }
                            
                        }
                        .padding(.horizontal, 16.0)
                        .padding(.top, 16.0)
                    }
                }
                
            }
            .navigationBarTitle("Progress Timeline")
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
}

struct Timeline_Previews: PreviewProvider {
    static var previews: some View {
        Timeline()
    }
}
