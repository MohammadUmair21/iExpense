//
//  ContentView.swift
//  iExpense
//
//  Created by Umair on 25/03/24.
//

import SwiftUI

struct ExpenseStyle: ViewModifier {
    let expenseItem: ExpenseItem
    func body(content: Content) -> some View {
            switch expenseItem.amount {
            case 0..<100:
                        content
                            .foregroundColor(.green)
                    case 10..<1000:
                        content
                            .foregroundColor(.blue)
                    default:
                        content
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                }
            }

extension View {
        func expenseStyle(for expenseItem: ExpenseItem) -> some View {
                        modifier(ExpenseStyle(expenseItem: expenseItem))
                    }
                }

struct ExpenseItem : Identifiable, Codable, Equatable{
    var id = UUID()
    let name : String
    let type : String
    let amount : Double
}

@Observable
class Expenses{
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey:"Items")
            }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
    var personalItems: [ExpenseItem] {
            items.filter { $0.type == "Personal" }
        }
        
        var businessItems: [ExpenseItem] {
            items.filter { $0.type == "Business" }
        }
}

struct ContentView: View {
    
    @State var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView{
            List{
                ExpenseSection(title: "Business", expenses: expenses.businessItems, deleteItems: removeBusinessItems)
                                
                                ExpenseSection(title: "Personal", expenses: expenses.personalItems, deleteItems: removePersonalItems)
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button("Add Expense", systemImage: "plus"){
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: expenses)
            }
        }
    }
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]){
        var objectsToDelete = IndexSet()
                
                for offset in offsets {
                    let item = inputArray[offset]
                    
                    if let index = expenses.items.firstIndex(of: item) {
                        objectsToDelete.insert(index)
                    }
                }
                
                expenses.items.remove(atOffsets: objectsToDelete)
            }
    func removePersonalItems(at offsets: IndexSet) {
            removeItems(at: offsets, in: expenses.personalItems)
        }
        
        func removeBusinessItems(at offsets: IndexSet) {
            removeItems(at: offsets, in: expenses.businessItems)
        }
        
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
    }
}

#Preview {
    ContentView()
}
