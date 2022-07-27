//
//  ContentView.swift
//  producTreevity
//
//  Created by Jessica Geofanie on 22/07/22.
//

import SwiftUI

struct ContentView: View {
    @State private var willMoveToTreeCollection = false
    @State private var willMoveToTimeline = false
    @State private var willMovetoNewProject = false
    
    @State var img = "pink-tree"
    
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
                
                Text("Learn Core Data")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.37, green: 0.42, blue: 0.30))
                    .padding(.top, 32.0)
                
                Text("1/6 Task Finished")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.82, green: 0.55, blue: 0.35))
                TreeView
                TaskView
                
                Spacer()
            }
            .padding(.all, 16.00)
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
                    img = "dirt"
                } label: {
                    Image(systemName: "chevron.left.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(.brown)
                
                Image(img).resizable()
                    .frame(width: 238, height: 260, alignment: .center)
                
                Button {
                    img = "pink-tree"
                } label: {
                    Image(systemName: "chevron.right.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(.brown)
            }
        }
    }
    var TaskView:some View{
        List {
            FinishedView
                .listRowSeparator(.hidden)
            InProgressView
                .listRowSeparator(.hidden)
            NotStartedView
                .listRowSeparator(.hidden)
            FinishedView
                .listRowSeparator(.hidden)
        }
        .listRowSeparator(.hidden)
        .frame(height: 350.0)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
        
    }
    
    var FinishedView: some View{
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
    
    var InProgressView:some View{
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
    
    var NotStartedView: some View{
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
    
    var TreeCount:some View{
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(width: 65, height: 30, alignment: .leading)
            HStack{
                Image("tree-count")
                    .resizable()
                    .frame(width: 22, height: 22, alignment: .leading)
                Text("6")
                
            }
            .foregroundColor(.black)
        }
        .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color(red: 0.10, green: 0.33, blue: 0.16)))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            //            MainView()
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
