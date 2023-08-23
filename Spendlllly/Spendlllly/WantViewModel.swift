//
//  WantViewModel.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 22/01/1445 AH.
//

import Foundation
import CoreData

class WantViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var WantArray: [ExpenseWant] = []
    @Published var SavingArray: [ExpenseSaving] = []
    @Published var NeedArray: [ExpenseNeed] = []
    let calendar = Calendar.current
    let currentDate = Date()
    
    

    
    
    func fetchWantsData(category:String) {
        if(category=="Want"){
            
            
            let request = NSFetchRequest<ExpenseWant>(entityName: "ExpenseWant")
            
            do {
                WantArray = try viewContext.fetch(request)
            }catch {
                print("DEBUG: Some error occured while fetching")
            }
            
        }else if(category=="Need"){
            let request = NSFetchRequest<ExpenseNeed>(entityName: "ExpenseNeed")
            
            do {
                NeedArray = try viewContext.fetch(request)
            }catch {
                print("DEBUG: Some error occured while fetching")
            }
        }else if(category=="Saving"){
            
            let request = NSFetchRequest<ExpenseSaving>(entityName: "ExpenseSaving")
            
            do {
                SavingArray = try viewContext.fetch(request)
            }catch {
                print("DEBUG: Some error occured while fetching")
            }
        }
                
    }
    
    
    func createDummyDate(){
        
        
        
    }
    
    func addDataToCoreData(name: String, amount: Double,category:String) {
        
        if(category=="Want"){
            
            let want = ExpenseWant(context: viewContext)
            if(name=="None"){
                want.name = "Transaction"}
            else{
                want.name = name
            }
            want.amount = amount
            want.date = Date() // Set the current date and time
            save()
            self.fetchWantsData(category:category)
            
        }else if(category=="Need"){
            
            let want = ExpenseNeed(context: viewContext)
            if(name=="None"){
                want.name = "Transaction"}
            else{
                want.name = name
            }
            want.amount = amount
            
            want.date = Date() // Set the current date and time
            save()
            self.fetchWantsData(category:category)
            
        }else if(category=="Savings"){
            
            let want = ExpenseSaving(context: viewContext)
            if(name=="None"){
                want.name = "Transaction"}
            else{
                want.name = name
            }
            want.amount = amount
            want.date = Date() // Set the current date and time
            save()
            self.fetchWantsData(category:category)
            
        }
        
        
        
        
        
      
    }
    
    func save() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving")
        }
    }
    
    
    func WeeklyExpense() -> (Sun: Int, Mon: Int, Tues: Int, Wed: Int, Thurs: Int, Fri: Int) {
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))

        var needExpensesByDay: [Int: Int] = [:]

        for item in WantArray {
            guard let expenseDate = item.date else {
                continue
            }

            if calendar.isDate(expenseDate, equalTo: startOfWeek!, toGranularity: .weekOfYear) {
                let dayOfWeek = calendar.component(.weekday, from: expenseDate)
                let expenseAmount = Int(item.amount)

                print(expenseAmount)

                if let existingExpense = needExpensesByDay[dayOfWeek] {
                        needExpensesByDay[dayOfWeek] = existingExpense - expenseAmount
                } else {
                    needExpensesByDay[dayOfWeek] = -expenseAmount
                }
            }
        }
        
        // Check if any values are negative and set them to 0
         for (day, expense) in needExpensesByDay {
             if expense < 0 {
                 needExpensesByDay[day] = -expense
             }else if expense > 0{
                 needExpensesByDay[day] = 0
             }
         }


        let totalExpenses: (Sun: Int, Mon: Int, Tues: Int, Wed: Int, Thurs: Int, Fri: Int) = (
            needExpensesByDay[1] ?? 0,
            needExpensesByDay[2] ?? 0,
            needExpensesByDay[3] ?? 0,
            needExpensesByDay[4] ?? 0,
            needExpensesByDay[5] ?? 0,
            needExpensesByDay[6] ?? 0
        )

        return totalExpenses
    }


  
    
    func WeeklyNeedExpense() -> (Sun: Int, Mon: Int, Tues: Int, Wed: Int, Thurs: Int, Fri: Int) {
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))

        var needExpensesByDay: [Int: Int] = [:]

        for item in NeedArray {
            guard let expenseDate = item.date else {
                continue
            }

            if calendar.isDate(expenseDate, equalTo: startOfWeek!, toGranularity: .weekOfYear) {
                let dayOfWeek = calendar.component(.weekday, from: expenseDate)
                let expenseAmount = Int(item.amount)

                print(expenseAmount)

                if let existingExpense = needExpensesByDay[dayOfWeek] {
                    if expenseAmount >= existingExpense {
                        needExpensesByDay[dayOfWeek] = 0
                    } else {
                        needExpensesByDay[dayOfWeek] = existingExpense - expenseAmount
                    }
                } else {
                    needExpensesByDay[dayOfWeek] = -expenseAmount
                }
            }
        }
        // Check if any values are negative and set them to 0
         for (day, expense) in needExpensesByDay {
             if expense < 0 {
                 needExpensesByDay[day] = -expense
             }else if expense > 0{
                 needExpensesByDay[day] = 0
             }
         }

        let totalExpenses: (Sun: Int, Mon: Int, Tues: Int, Wed: Int, Thurs: Int, Fri: Int) = (
            needExpensesByDay[1] ?? 0,
            needExpensesByDay[2] ?? 0,
            needExpensesByDay[3] ?? 0,
            needExpensesByDay[4] ?? 0,
            needExpensesByDay[5] ?? 0,
            needExpensesByDay[6] ?? 0
        )

        return totalExpenses
    }
    
    
    func WeeklySavings() -> (Sun: Int, Mon: Int, Tues: Int, Wed: Int, Thurs: Int, Fri: Int) {
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))

        var wantExpensesByDay: [Int: Int] = [:]
        
        for item in SavingArray{

            guard let expenseDate = item.date else {
                continue
            }
            
            if calendar.isDate(expenseDate, equalTo: startOfWeek!, toGranularity: .weekOfYear) {
                let dayOfWeek = calendar.component(.weekday, from: expenseDate)
                let expenseAmount = Int(item.amount)
                
                if let existingExpense = wantExpensesByDay[dayOfWeek] {
                    wantExpensesByDay[dayOfWeek] = existingExpense + expenseAmount
                } else {
                    wantExpensesByDay[dayOfWeek] = expenseAmount
                }
            }
        }
        
        for (day, expense) in wantExpensesByDay {
            if expense < 0 {
                wantExpensesByDay[day] = 0
            }
        }
        
        let totalExpenses: (Sun: Int, Mon: Int, Tues: Int, Wed: Int, Thurs: Int, Fri: Int) = (
            wantExpensesByDay[1] ?? 0,
            wantExpensesByDay[2] ?? 0,
            wantExpensesByDay[3] ?? 0,
            wantExpensesByDay[4] ?? 0,
            wantExpensesByDay[5] ?? 0,
            wantExpensesByDay[6] ?? 0
        )
        
        return totalExpenses
    }
    
    
    func MonthlyExpenses() -> (January: Int, February: Int, March: Int, April: Int, May: Int, June: Int, July: Int, August: Int, September: Int, October: Int, November: Int, December: Int) {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))
        
        var monthlyExpensesByMonth: [Int: Int] = [:]
        
        for item in WantArray {
            guard let expenseDate = item.date else {
                continue
            }
            
            if calendar.isDate(expenseDate, equalTo: startOfMonth!, toGranularity: .month) {
                let month = calendar.component(.month, from: expenseDate)
                let expenseAmount = Int(item.amount)
                
                if let existingExpense = monthlyExpensesByMonth[month] {
                    
                        monthlyExpensesByMonth[month] = existingExpense - expenseAmount
                } else {
                    monthlyExpensesByMonth[month] = -expenseAmount
                }
            }
        }
        
        // Check if any values are negative and set them to 0
          for (month, expense) in monthlyExpensesByMonth {
              if expense < 0 {
                  monthlyExpensesByMonth[month] = -expense
              }else if(expense>0){
                  monthlyExpensesByMonth[month]=0
              }
          }
        
        let totalExpenses: (January: Int, February: Int, March: Int, April: Int, May: Int, June: Int, July: Int, August: Int, September: Int, October: Int, November: Int, December: Int) = (
            monthlyExpensesByMonth[1] ?? 0,
            monthlyExpensesByMonth[2] ?? 0,
            monthlyExpensesByMonth[3] ?? 0,
            monthlyExpensesByMonth[4] ?? 0,
            monthlyExpensesByMonth[5] ?? 0,
            monthlyExpensesByMonth[6] ?? 0,
            monthlyExpensesByMonth[7] ?? 0,
            monthlyExpensesByMonth[8] ?? 0,
            monthlyExpensesByMonth[9] ?? 0,
            monthlyExpensesByMonth[10] ?? 0,
            monthlyExpensesByMonth[11] ?? 0,
            monthlyExpensesByMonth[12] ?? 0
        )
        
        return totalExpenses
    }
    
    func MonthlyNeedExpenses() -> (January: Int, February: Int, March: Int, April: Int, May: Int, June: Int, July: Int, August: Int, September: Int, October: Int, November: Int, December: Int) {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))
        
        var monthlyExpensesByMonth: [Int: Int] = [:]
        
        for item in NeedArray {
            guard let expenseDate = item.date else {
                continue
            }
            
            if calendar.isDate(expenseDate, equalTo: startOfMonth!, toGranularity: .month) {
                let month = calendar.component(.month, from: expenseDate)
                let expenseAmount = Int(item.amount)
                
                if let existingExpense = monthlyExpensesByMonth[month] {
                        monthlyExpensesByMonth[month] = existingExpense + expenseAmount
                } else {
                    monthlyExpensesByMonth[month] = -expenseAmount
                }
            }
        }
        
        // Check if any values are negative and set them to 0
          for (month, expense) in monthlyExpensesByMonth {
              if expense < 0 {
                  monthlyExpensesByMonth[month] = -expense
              }else if(expense>0){
                  monthlyExpensesByMonth[month]=0
              }
          }
        
        let totalExpenses: (January: Int, February: Int, March: Int, April: Int, May: Int, June: Int, July: Int, August: Int, September: Int, October: Int, November: Int, December: Int) = (
            monthlyExpensesByMonth[1] ?? 0,
            monthlyExpensesByMonth[2] ?? 0,
            monthlyExpensesByMonth[3] ?? 0,
            monthlyExpensesByMonth[4] ?? 0,
            monthlyExpensesByMonth[5] ?? 0,
            monthlyExpensesByMonth[6] ?? 0,
            monthlyExpensesByMonth[7] ?? 0,
            monthlyExpensesByMonth[8] ?? 0,
            monthlyExpensesByMonth[9] ?? 0,
            monthlyExpensesByMonth[10] ?? 0,
            monthlyExpensesByMonth[11] ?? 0,
            monthlyExpensesByMonth[12] ?? 0
        )
        
        return totalExpenses
    }
    
    
    func monthlySaving() -> (January: Int, February: Int, March: Int, April: Int, May: Int, June: Int, July: Int, August: Int, September: Int, October: Int, November: Int, December: Int) {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))
        
        var monthlyExpensesByMonth: [Int: Int] = [:]
        
        for item in SavingArray {
            guard let expenseDate = item.date else {
                continue
            }
            
            if calendar.isDate(expenseDate, equalTo: startOfMonth!, toGranularity: .month) {
                let month = calendar.component(.month, from: expenseDate)
                let expenseAmount = Int(item.amount)
                
                if let existingExpense = monthlyExpensesByMonth[month] {
                    monthlyExpensesByMonth[month] = existingExpense + expenseAmount
                } else {
                    monthlyExpensesByMonth[month] = expenseAmount
                }
            }
        }
        for (month, expense) in monthlyExpensesByMonth {
                if expense < 0 {
                    monthlyExpensesByMonth[month] = 0
                }
            }
            
        let totalExpenses: (January: Int, February: Int, March: Int, April: Int, May: Int, June: Int, July: Int, August: Int, September: Int, October: Int, November: Int, December: Int) = (
            monthlyExpensesByMonth[1] ?? 0,
            monthlyExpensesByMonth[2] ?? 0,
            monthlyExpensesByMonth[3] ?? 0,
            monthlyExpensesByMonth[4] ?? 0,
            monthlyExpensesByMonth[5] ?? 0,
            monthlyExpensesByMonth[6] ?? 0,
            monthlyExpensesByMonth[7] ?? 0,
            monthlyExpensesByMonth[8] ?? 0,
            monthlyExpensesByMonth[9] ?? 0,
            monthlyExpensesByMonth[10] ?? 0,
            monthlyExpensesByMonth[11] ?? 0,
            monthlyExpensesByMonth[12] ?? 0
        )
        
        return totalExpenses
    }
    
    
    
    
    
    func needmonthlytotal()-> Double {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))
        
        var totalExpenses: Double = 0.0
        
        for item in NeedArray {
            guard let expenseDate = item.date else {
                continue
            }
            
            if calendar.isDate(expenseDate, equalTo: startOfMonth!, toGranularity: .month) {
                totalExpenses += Double(item.amount)
            }
        }
        
        return totalExpenses
    }
    func wantmonthlytotal()-> Double {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))
        
        var totalExpenses: Double = 0.0
        
        for item in WantArray {
            guard let expenseDate = item.date else {
                continue
            }
            
            if calendar.isDate(expenseDate, equalTo: startOfMonth!, toGranularity: .month) {
                totalExpenses += Double(item.amount)
            }
        }
        
        return totalExpenses
    }
    
    func savingmonthlytotal()-> Double {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))
        
        var totalExpenses: Double = 0.0
        
        for item in SavingArray {
            guard let expenseDate = item.date else {
                continue
            }
            
            if calendar.isDate(expenseDate, equalTo: startOfMonth!, toGranularity: .month) {
                totalExpenses += Double(item.amount)
            }
        }
        
        return totalExpenses
    }
    
    
    
    
    
    
    
    
    /*func MonthlyExpenses() -> (January: Int, February: Int, March: Int, April: Int, May: Int, June: Int, July: Int, August: Int, September: Int, October: Int, November: Int, December: Int) {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))
        
        var monthlyExpensesByMonth: [Int: Int] = [:]
        
        for item in WantArray {
            guard let expenseDate = item.date else {
                continue
            }
            
            if calendar.isDate(expenseDate, equalTo: startOfMonth!, toGranularity: .month) {
                let month = calendar.component(.month, from: expenseDate)
                let expenseAmount = Int(item.amount)
                
                if let existingExpense = monthlyExpensesByMonth[month] {
                    monthlyExpensesByMonth[month] = existingExpense - expenseAmount
                } else {
                    monthlyExpensesByMonth[month] = expenseAmount
                }
            }
        }
        // Check if any values are negative and set them to 0
          for (month, expense) in monthlyExpensesByMonth {
              if expense < 0 {
                  monthlyExpensesByMonth[month] = 0
              }
          }
        let totalExpenses: (January: Int, February: Int, March: Int, April: Int, May: Int, June: Int, July: Int, August: Int, September: Int, October: Int, November: Int, December: Int) = (
            monthlyExpensesByMonth[1] ?? 0,
            monthlyExpensesByMonth[2] ?? 0,
            monthlyExpensesByMonth[3] ?? 0,
            monthlyExpensesByMonth[4] ?? 0,
            monthlyExpensesByMonth[5] ?? 0,
            monthlyExpensesByMonth[6] ?? 0,
            monthlyExpensesByMonth[7] ?? 0,
            monthlyExpensesByMonth[8] ?? 0,
            monthlyExpensesByMonth[9] ?? 0,
            monthlyExpensesByMonth[10] ?? 0,
            monthlyExpensesByMonth[11] ?? 0,
            monthlyExpensesByMonth[12] ?? 0
        )
        
        return totalExpenses
    }*/
    
    /* func WeeklyNeedExpense() -> (Sun: Int, Mon: Int, Tues: Int, Wed: Int, Thurs: Int, Fri: Int) {
         let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))

         var wantExpensesByDay: [Int: Int] = [:]
         
         for item in NeedArray{

             guard let expenseDate = item.date else {
                 continue
             }
             
             if calendar.isDate(expenseDate, equalTo: startOfWeek!, toGranularity: .weekOfYear) {
                 let dayOfWeek = calendar.component(.weekday, from: expenseDate)
                 let expenseAmount = Int(item.amount)
                 
                 print(expenseAmount)
                 if let existingExpense = wantExpensesByDay[dayOfWeek] {
                    
                     wantExpensesByDay[dayOfWeek] = existingExpense + expenseAmount
                   

                 } else {
                     wantExpensesByDay[dayOfWeek] = expenseAmount
                 }
             }
         }
         
         // Check if any values are negative and set them to 0
          for (day, expense) in wantExpensesByDay {
              if expense < 0 {
                  wantExpensesByDay[day] = 0
              }
          }
         
         let totalExpenses: (Sun: Int, Mon: Int, Tues: Int, Wed: Int, Thurs: Int, Fri: Int) = (
             wantExpensesByDay[1] ?? 0,
             wantExpensesByDay[2] ?? 0,
             wantExpensesByDay[3] ?? 0,
             wantExpensesByDay[4] ?? 0,
             wantExpensesByDay[5] ?? 0,
             wantExpensesByDay[6] ?? 0
         )
         
         return totalExpenses
     }*/
}

