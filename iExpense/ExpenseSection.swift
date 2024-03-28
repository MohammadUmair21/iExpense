//
//  ExpenseSection.swift
//  iExpense
//
//  Created by Umair on 28/03/24.
//

import SwiftUI

struct ExpenseSection: View {
    
    let title: String
        let expenses: [ExpenseItem]
        let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        
        Section(title) {
                    ForEach(expenses) { item in
                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(item.name)
                                                    .font(.headline)
                                                Text(item.type)
                                            }
                                            
                                            Spacer()
                                            
                                            Text(item.amount, format: .localCurrency)
                                                .expenseStyle(for: item)
                        }
                                    }
                                    .onDelete(perform: deleteItems)
                                }
                            }
                        }

                struct ExpenseSection_Previews: PreviewProvider {
                            static var previews: some View {
                                ExpenseSection(title: "Example", expenses: [], deleteItems: { _ in })
            }
    }
