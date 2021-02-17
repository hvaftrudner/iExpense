//
//  addView.swift
//  iExpense
//
//  Created by Kristoffer Eriksson on 2021-02-16.
//

import SwiftUI

struct addView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = "Failure!"
    @State private var alertMessage = "Amount must be an Number!"
    
    static let types = ["Business", "Personal"]
    
    
    var body: some View {
        NavigationView{
            Form {
                TextField("name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(Self.types, id: \.self){
                        Text($0)
                    }
                }
                
                TextField("amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing:
                Button("save"){
                    //checking for an int in amount
                    if let actualAmount = Int(self.amount){
                        let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                        
                        
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                        
                    } else {
                        //challenge 3
                        self.showingAlert = true
                    }
                }
            )
        }
        //challenge 3
        .alert(isPresented: $showingAlert){
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("ok")))
        }
    }
}

struct addView_Previews: PreviewProvider {
    static var previews: some View {
        addView(expenses: Expenses())
    }
}
