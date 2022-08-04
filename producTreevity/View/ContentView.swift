//
//  ContentView.swift
//  producTreevity
//
//  Created by Jessica Geofanie on 22/07/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = CoreDataViewModel()
    
    @State private var willMoveToTreeCollection = false
    @State private var willMoveToTimeline = false
    @State private var willMovetoNewProject = false
    @State var taskName = ""
    @State var taskProgress = 0
    
    @State var progressSelection:String = "Not Started"
    @State var project:ProjectEntity = CoreDataViewModel().projects[0]
    @State var task:TaskEntity = CoreDataViewModel().projects[0].task[0]
    @State private var showModal = false
    @State var idx:Int = 0
    
    var body: some View {
        
        ZStack{
            Color(red: 0.98, green: 0.99, blue: 0.84).ignoresSafeArea()
            VStack{
                HStack(alignment: .top, spacing: 8.0){
                    Button {
                        willMoveToTreeCollection = true
                    } label: {
                        TreeCount
                    }
                    
                    Spacer()
                    Button {
                        willMoveToTimeline = true
                    } label: {
                        Image(systemName: "calendar.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(red: 0.37, green: 0.42, blue: 0.30))
                    }
                    
                    Button {
                        willMovetoNewProject = true
                    } label: {
                        ZStack{
                            Circle()
                                .fill(.white)
                                .frame(width: 30, height: 30, alignment: .trailing)
                            VStack(spacing: 0.0){
                                Image(systemName: "plus")
                                    .frame(width: 16, height: 16, alignment: .center)
                                Text("Add")
                                    .font(.system(size: 8))
                            }
                            .foregroundColor(.black)
                        }
                        .overlay(Circle()
                            .stroke(Color(red: 0.10, green: 0.33, blue: 0.16)))
                    }
                }
                if(vm.projects.count>0)
                {
                    
                    Text(vm.projects[idx].projectName ?? "")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.37, green: 0.42, blue: 0.30))
                        .padding(.top, 32.0)
                    

                    Text("\(vm.projects[idx].finishedTask)/\(vm.projects[idx].task.count) Task Finished")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.82, green: 0.55, blue: 0.35))
                    TreeView

                    if(vm.projects.count>0){
                        TaskView
                            .onAppear(perform: {vm.getTasks()})
                            .padding(.top,16)
                    }
                    
                    
                }
                else{
                    Text("No Project")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.37, green: 0.42, blue: 0.30))
                        .padding(.top, 32.0)
                    
                    noTreeView
                    
                    Button {
                        willMovetoNewProject = true
                    } label: {
                        VStack {
                            ZStack{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 80, height: 80, alignment: .trailing)
                                VStack(spacing: 0.0){
                                    Image(systemName: "plus")
                                        .font(.system(size: 48))
                                    
                                }
                                .foregroundColor(.black)
                            }
                            .overlay(Circle()
                                .stroke(Color(red: 0.10, green: 0.33, blue: 0.16)))
                            
                            Text("New Tree")
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 0.37, green: 0.42, blue: 0.30))
                        }
                    }
                }
                Spacer()
            }
            .padding(.all, 16.00)
            ProgressModal(isShowing: $showModal, project: $project, task: $task, progressBefore: $progressSelection)
        }
        .navigate(to: TreeCollection(), when: $willMoveToTreeCollection)
        .navigate(to: Timeline(), when: $willMoveToTimeline)
        .navigate(to: NewProject(), when: $willMovetoNewProject)
        
    }
    
    
    var noTreeView:some View{
        Image("dirt").resizable()
            .frame(width: 238, height: 260, alignment: .center)
    }
    
    var TreeView:some View{
        
        ZStack{
            HStack{
                Button {
                    if idx-1 < 0{
                        idx = vm.projects.count-1
                    }
                    else{
                        idx = idx - 1
                    }
                                        print(vm.tasks)
                } label: {
                    Image(systemName: "chevron.left.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(.brown)
                Image(vm.projects[idx].projectImageType ?? "").resizable()
                    .frame(width: 238, height: 260, alignment: .center)
                
                
                
                Button {
                    if idx+1 == vm.projects.count{
                        idx = 0
                    }
                    else{
                        idx = idx + 1
                    }
                    //                    projectEntity = vm.projects[idx]
                } label: {
                    Image(systemName: "chevron.right.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(.brown)
                
            }
        }
    }
    
    var TreeCount:some View{
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(width: 65, height: 30, alignment: .leading)
            HStack{
                Image("tree-count")
                    .resizable()
                    .frame(width: 22, height: 22, alignment: .leading)
                Text("\(vm.projects.count)")
                
            }
            .foregroundColor(.black)
        }
        .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color(red: 0.10, green: 0.33, blue: 0.16)))
    }
    
    var FinishedView: some View{
        Button {
            showModal = true
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color(red: 0.90, green: 0.73, blue: 0.58))
                HStack{
                    Image("water")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Core Data Stack")
                        .lineLimit(nil)
                        .padding(.vertical, 3.0)
                        .foregroundColor(.black)
                    Spacer()
                    Text("Finished")
                        .foregroundColor(Color(red: 0.17, green: 0.51, blue: 0.02))
                }
                .padding(.trailing, 8.0)
            }
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color(red: 0.17, green: 0.51, blue: 0.02)))
            .listRowBackground(Color(red: 0.98, green: 0.99, blue: 0.84))
        }
        
        
    }
    
    var InProgressView:some View{
        Button {
            showModal = true
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color(red: 0.90, green: 0.73, blue: 0.58))
                HStack{
                    Image("water")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Core Data Model")
                        .lineLimit(nil)
                        .padding(.vertical, 3.0)
                        .foregroundColor(.black)
                    Spacer()
                    Text("In Progress")
                        .foregroundColor(Color(red: 0.52, green: 0.43, blue: 0.06))
                }
                .padding(.trailing, 8.0)
            }
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color(red: 0.52, green: 0.43, blue: 0.06)))
            .listRowBackground(Color(red: 0.98, green: 0.99, blue: 0.84))
        }
    }
    
    var NotStartedView: some View{
        Button {
            showModal = true
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color(red: 0.90, green: 0.73, blue: 0.58))
                HStack(spacing: 8.0){
                    Image("water")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Fetch Request")
                        .lineLimit(nil)
                        .padding(.vertical, 3.0)
                        .foregroundColor(.black)
                    Spacer()
                    Text("Not Started")
                        .foregroundColor(Color(red: 0.78, green: 0.04, blue: 0.04))
                }
                .padding(.trailing, 8.0)
            }
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color(red: 0.78, green: 0.04, blue: 0.04)))
            .listRowBackground(Color(red: 0.98, green: 0.99, blue: 0.84))
        }
        
        
    }
    
    var TaskView: some View{
        ZStack {
            ScrollView {
                ForEach(0..<vm.projects[idx].task.count, id: \.self){ index in
                    if(vm.projects[idx].task[index].taskProgress == "Finished"){
                        Button {
                            showModal = true
                            progressSelection = "Finished"
                            project = vm.projects[idx]
                            task = vm.projects[idx].task[index]
                            
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(Color(red: 0.90, green: 0.73, blue: 0.58))
                                HStack{
                                    Image("water")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text(vm.projects[idx].task[index].taskName ?? "")
                                        .lineLimit(nil)
                                        .padding(.vertical, 3.0)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text("Finished")
                                        .foregroundColor(Color(red: 0.17, green: 0.51, blue: 0.02))
                                }
                                .padding(.trailing, 8.0)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(red: 0.17, green: 0.51, blue: 0.02)))
                            .listRowBackground(Color(red: 0.98, green: 0.99, blue: 0.84))
                        }
                    }
                    else if(vm.projects[idx].task[index].taskProgress == "In Progress"){
                        Button {
                            showModal = true
                            progressSelection = "In Progress"
                            project = vm.projects[idx]
                            task = vm.projects[idx].task[index]
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(Color(red: 0.90, green: 0.73, blue: 0.58))
                                HStack{
                                    Image("water")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text(vm.projects[idx].task[index].taskName ?? "")
                                        .lineLimit(nil)
                                        .padding(.vertical, 3.0)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text("In Progress")
                                        .foregroundColor(Color(red: 0.52, green: 0.43, blue: 0.06))
                                }
                                .padding(.trailing, 8.0)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(red: 0.52, green: 0.43, blue: 0.06)))
                            .listRowBackground(Color(red: 0.98, green: 0.99, blue: 0.84))
                        }
                    }
                    else{
                        Button {
                            showModal = true
                            progressSelection = "Not Started"
                            project = vm.projects[idx]
                            task = vm.projects[idx].task[index]
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(Color(red: 0.90, green: 0.73, blue: 0.58))
                                HStack(spacing: 8.0){
                                    Image("water")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text(vm.projects[idx].task[index].taskName ?? "")
                                        .lineLimit(nil)
                                        .padding(.vertical, 3.0)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text("Not Started")
                                        .foregroundColor(Color(red: 0.78, green: 0.04, blue: 0.04))
                                }
                                .padding(.trailing, 8.0)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(red: 0.78, green: 0.04, blue: 0.04)))
                            .listRowBackground(Color(red: 0.98, green: 0.99, blue: 0.84))
                        }
                    }
                    

                }

            }
            .frame(width: 300 )
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State var progressSelected:String = "Not Started"
    static var previews: some View {
        Group {
            ContentView()
//            ContentView(progressSelection: $progressSelected, idx: 0)
//            ContentView(idx: 0, progressSelection = "Not Started")
        }
    }
}

struct MainView: View{
    
    @State var isView2Shown = false
    
    
    var body: some View{
        ZStack{
            View1(isView2Shown: $isView2Shown)
            
            if isView2Shown{
                View2(isView2Shown: $isView2Shown)
            }
        }
        
    }
}

struct View1: View{
    
    @Binding var isView2Shown: Bool
    
    var body: some View{
        ZStack{
            Color.red
            Button {
                isView2Shown.toggle()
            } label: {
                Text("Presee")
            }
        }
    }
}

struct View2: View{
    
    @Binding var isView2Shown: Bool
    
    var body: some View{
        Color.green
    }
}
