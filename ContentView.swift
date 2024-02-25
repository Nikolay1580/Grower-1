//
//  ContentView.swift
//  IosProto
//
//  Created by Nikolay Tsonev on 15/02/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var growerName: String = "Grower 1"
    

    var body: some View {
        
        NavigationView {
            
            
            // Main Veiw
            VStack {
                VStack(alignment: .center) {
                    TextField("Name your grower", text: $growerName)
                        .padding()
                    
                }

                // will display the PH, temp and moisture
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: UIScreen.main.bounds.width-25, height:140)
                        .foregroundColor( Color(red: 220.0/255.0, green: 220.0/255.0, blue: 180.0/255.0))
                    
                    
                    HStack(spacing: -10) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.blue)
                                .padding()
                            
                            VStack {
                                Text("PH")
                                
                                Text("6.85")
                            }
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.red)
                                .padding()
                            
                            VStack {
                                Text("Temparature")
                                
                                Text("34.6°C")
                            }
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.green)
                                .padding()
                            
                            VStack {
                                Text("Moisture")
                                
                                Text("MOIST")
                            }
                        }
                    }
                }
                // END OF display of main temps
                
                // displau your favourite vegtables
                
                HStack(alignment: .center, spacing: 20) {
                    // this will be a semi done tomatoto plant
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 170, height: 140)
                            .foregroundColor(.mint)
                        
                        VStack {
                            Text("THERE SHOULD BE AN IMAGE HERE")
                                .frame(width:150)
                                .padding()
                            
                            HStack {
                                Text("3")
                                Image(systemName: "arrow.right.to.line")
                                
                                Text("6")
                            }
                            
                            Text("Weeks")
                        }
                        
                    }
                                        
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 170, height: 140)
                            .foregroundColor(.teal)
                        
                        VStack {
                            Text("MEOW")
                                .frame(width:150)
                                .padding()
                            
                            HStack {
                                Text("3")
                                Image(systemName: "arrow.right.to.line")
                                
                                Text("6")
                            }
                            
                            Text("Weeks")
                        }
                        
                    }
                    
                }
            }
            
            
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
