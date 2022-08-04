//
//  NewProject.swift
//  producTreevity
//
//  Created by Jessica Geofanie on 25/07/22.
//

import SwiftUI

struct Tasks: Identifiable {
    var name: String
    let id = UUID()
}

struct NewProject: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State private var showingAlert = false
    @State private var showingAlertEmpty = false
    @State private var willMoveToDashboard = false
    @Environment(\.dismiss) var dismiss
    @State var editMode: EditMode = .active
    @State private var newTask = ""
    @State private var rootTask = ""
    @State private var listTasks = [String]()
    
    
    let treeName:[String] = ["pink-tree", "cactus", "orange-tree", "apple-tree","coconut-tree"]
    
    @State private var listOfTasks:[String] = ["Core Data Stack", "Core Data Model", "Fetch Request", "Migrations"]
    @State var selectedTreeName:String = ""
    @State var selectedTree: Int? = nil
    @State private var treeNameValue:String = ""
    //    @State var tasks:[Tasks]
    var body: some View {
        NavigationView{
            ZStack{
                Color(red: 0.98, green: 0.99, blue: 0.84).ignoresSafeArea()
                VStack(alignment: .center, spacing: 12.0){
                    VStack(alignment: .leading){
                        Text("Project Tree Name")
                            .fontWeight(.semibold)
                            .font(.system(size: 17))
                        TextField(" Name of yout project", text: $treeNameValue)
                            .frame(width: 360, height: 44, alignment: .leading)
                            .foregroundColor(.black)
                            .background(.white)
                            .cornerRadius(10)
                        
                    }
                    
                    VStack(alignment: .leading){
                        Text("Select Tree")
                            .fontWeight(.semibold)
                            .font(.system(size: 17))
                        ScrollView(.horizontal) {
                            HStack{
                                
                                ForEach(0..<treeName.count, id: \.self){ index in
                                    Image(treeName[index])
                                        .resizable()
                                        .frame(width: 74, height: 79)
                                        .opacity(selectedTree == index ? 1 : 0.3) // Change opacity based on selection
                                        .onTapGesture {
                                            // Set the selected row when the image is tapped.
                                            selectedTree = index
                                            selectedTreeName = treeName[index]
                                            print(selectedTreeName)
                                        }
                                }
                                
                                
                                
                            }
                        }
                    }
                    VStack(alignment: .leading){
                        Text("Add Task")
                            .fontWeight(.semibold)
                            .font(.system(size: 17))
                        List{
                            Section{
                                TextField("Enter your task", text: $newTask)
                            }
                            
                            Section{
                                ForEach(listTasks, id: \.self){ task in
                                    Text(task)
                                }
                                .onDelete(perform: delete)
                            }
                            
                        }
                        .listStyle(.plain)
                        .onSubmit(addNewTask)
                        .environment(\.editMode, $editMode)
                        .onAppear() {
                            UITableView.appearance().backgroundColor = UIColor(red: 0.98, green: 0.99, blue: 0.84, alpha: 1.00)
                            UITableViewCell.appearance().backgroundColor = UIColor(red: 0.98, green: 0.99, blue: 0.84, alpha: 1.00)
                            
                            //                            }
                        }
                        
                    }
                    
                    Text("Number of task(s): \(listTasks.count)")
                    Button {
                        print(listTasks)
                        guard !treeNameValue.isEmpty && !selectedTreeName.isEmpty && !listTasks.isEmpty else{
                            showingAlertEmpty = true
                            return
                        }
                        
                        let project = vm.createProject(name: treeNameValue, imageNameType: selectedTreeName)
                        for task in listTasks{
                            vm.createTask(taskName: task, taskProgress: "Not Started",projectEntity: project)
                        }
                        
                        treeNameValue = ""
                        selectedTreeName = ""
                        showingAlert = true
                    } label: {
                        Text("Create")
                            .fontWeight(.semibold)
                            .padding()
                            .background(Color(red: 0.64, green: 0.70, blue: 0.55))
                            .cornerRadius(10)
                            .foregroundColor(Color(red: 0.36, green: 0.10, blue: 0.00))
                    }
                    .alert("New Project Tree Successfully Created", isPresented: $showingAlert) {
                                Button("Okay") {
                                    willMoveToDashboard = true
                                }

                            }
                    .alert("You Must Fill All the Information Needed", isPresented: $showingAlertEmpty) {
                                Button("Okay") {
                                    
                                }

                            }
                }
                .padding(.all, 16.0)
                .navigationBarTitle("New Project Tree")
                .foregroundColor(Color(red: 0.36, green: 0.10, blue: 0.00))
                .navigationBarTitleDisplayMode(.large)
                .navigationBar(backgroundColor: Color(red: 0.64, green: 0.70, blue: 0.54), titleColor: Color(red: 0.36, green: 0.10, blue: 0.00))
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
            
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigate(to: ContentView(idx: 0), when: $willMoveToDashboard)
        
        
    }
        
    
    func delete(at offsets: IndexSet){
        listTasks.remove(atOffsets: offsets)
    }
    func addNewTask() {
        print(listTasks)
        withAnimation {
            listTasks.insert(newTask, at: 0)
        }
        newTask = ""
    }
}
struct NewProject_Previews: PreviewProvider {
    static var previews: some View {
        NewProject()
    }
}
