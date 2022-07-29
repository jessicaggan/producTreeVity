//
//  ProgressModal.swift
//  producTreevity
//
//  Created by Jessica Geofanie on 27/07/22.
//

import SwiftUI

struct ProgressModal: View {
    @StateObject var vm = CoreDataViewModel()
    @Binding var isShowing:Bool
    @State private var progressSelection = "Not Started"
    @Binding var project:ProjectEntity
    @Binding var task:TaskEntity
    @Binding var progressBefore:String
    let availableSelection = ["Not Started", "In Progress", "Finished"]
    var body: some View {
        ZStack(alignment: .center){
            if(isShowing){
                Color.black
                    .opacity(0.8)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
            VStack(alignment: .center){
                ZStack{
                    VStack(spacing: 10.0){
                        Text("Core Data Stack")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 16.0)
                        Text("Which level are you?")
                        Menu {
                            Picker("Select Progress", selection: $progressSelection){
                                ForEach(availableSelection, id: \.self){
                                    Text($0)
                                                                        }
                            }
                        } label: {
                            ZStack{
                                Text(progressSelection)
                                    .foregroundColor(.white)
                                    .frame(width: 250, height: 30, alignment: .center)
                                    .background(Color(red: 0.77, green: 0.70, blue: 0.55))
                                    .cornerRadius(8)
                                HStack{
                                    Spacer()
                                    Image(systemName: "arrowtriangle.down")
                                        .padding(.trailing, 16.0)

                                }
                                                            }
                            
                        }

                        Button {
                            print("Update")
                            isShowing = false
                            print(isShowing)
                            vm.updateProgress(project: project , task: task, progress: progressSelection, progressBefore: progressBefore)

                        } label: {
                            Text("Update")
                                .foregroundColor(.white)
                                .padding(.vertical, 8.0)
                                .padding(.horizontal, 16.0)
                                .background(.brown)
                                .cornerRadius(8)
                                
                        }
                        .padding(.top, 24.0)

                        Spacer()
                    }
                    .padding(.horizontal,30)
                }
                .frame(maxHeight:.infinity)
            }
            .frame(height: 200)
            .frame(maxWidth: 300)
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                    Rectangle()
                        .frame(height: 100)
                }
                    .foregroundColor(Color(red: 0.73, green: 0.81, blue: 0.64))
            )
        }
        }
    }
}

struct ProgressModal_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView(projectEntity: CoreDataViewModel().projects[CoreDataViewModel().projects.count-1])
        ContentView(idx: 0)
    }
}
