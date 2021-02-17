//
//  ContentView.swift
//  iExpense
//
//  Created by Kristoffer Eriksson on 2021-02-16.
//

import SwiftUI

struct amountView: View {
    
    let amount: Int
    
    var body: some View{
        self.customizeAmount()
    }
    
    func customizeAmount() -> Text {
        
        var newText: String = ""
        var color: Color = Color.black
        var font: Font = .caption2
        
        if amount <= 10 {
            newText = "$\(amount)"
            color = Color.red
            font = .title2
        } else if amount < 100 {
            newText = "$$\(amount)"
            color = Color.orange
            font = .title
        } else if amount >= 100 {
            newText = "$$\(amount)$$"
            color = Color.green
            font = .largeTitle
        }
        
        return Text(newText)
            .foregroundColor(color)
            .font(font)
    }
}

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    
    var body: some View {
        NavigationView {
            List{
                ForEach(expenses.items){ item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                            
                        }
                        Spacer()
                        
                        //Text("$\(item.amount)")
                        amountView(amount: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    //test seed code
                    //let expense = ExpenseItem(name: "Test", type: "Personal", price: 5)
                    //self.expenses.items.append(expense)
                    self.showingAddExpense = true
                }){
                    Image(systemName: "plus")
                }
            )
            
            .sheet(isPresented: $showingAddExpense){
                addView(expenses: self.expenses)
            }
        }
    }
    func removeItems(at offSets: IndexSet){
        expenses.items.remove(atOffsets: offSets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
