//
//  WantsHistory.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 22/01/1445 AH.
//

import SwiftUI
import CoreData





struct WantsHistory: View {
    @ObservedObject var viewModel : WantViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy, h:mm a"
        return formatter
    }()
    

    func removeExpense(at offsets: IndexSet) {
        for index in offsets {
            let expense = viewModel.WantArray[index]
            managedObjectContext.delete(expense)
        }
        do {
            try managedObjectContext.save()
        } catch {
            // handle the Core Data error
        }
        PersistenceController.shared.save()
        viewModel.fetchWantsData(category: "Want")

    }
    
    var body: some View {
        NavigationView {
            VStack(spacing:-40) {
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(hex: "5AA5E2"))
                        .frame(width: 400, height: 180)
                        .ignoresSafeArea()
                    HStack{
                       
                        Text("Wants")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.leading,30)
                            

                        Spacer()
                     
                    }.frame(width: 400,height: 90)
                        .padding([.bottom],20)
                    
                }.frame(width: 200,height: 100)
                
                List{
                    ForEach(viewModel.WantArray, id: \.id) { item in
                        HStack{
                            
                            VStack(alignment: .leading,spacing: 0){
                                Text(item.name ?? "Transaction")
                                    .fontWeight(.regular)
                                    .font(.system(size: 16))
                                    .padding([.leading, .trailing],10)
                                
                                if let date = item.date {
                                    Text(dateFormatter.string(from: date))
                                        .fontWeight(.regular)
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                        .padding([.leading, .trailing,.bottom],10)
                                } else {
                                    Text("Invalid Date")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                }
                                
                            }
                            Spacer()
                            Text( "\(String(item.amount)) SAR")
                                .fontWeight(.regular)
                                .font(.system(size: 16))
                            if(item.amount<0){
                                Image(systemName: "arrow.up.backward.square")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color(hex: "FF5757"))
                                    .padding([.trailing,.bottom,.top],10)
                            }else{
                                Image(systemName: "arrow.down.right.square")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color(hex: "6DB388"))
                                    .padding([.trailing,.bottom,.top],10)
                            }
                        }
                    }.onDelete(perform: removeExpense)
                }.frame(width: 450)
                .scrollContentBackground(.hidden)
   

                
                   
            }
        }
           
    }
}

struct WantsHistory_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

