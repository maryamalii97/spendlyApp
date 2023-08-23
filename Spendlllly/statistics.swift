//
//  statistics.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 23/01/1445 AH.
//
import SwiftUI
import SwiftUICharts
import CoreData

struct statistics: View {
    @ObservedObject var viewModel : WantViewModel
    
    let chartStyle = ChartStyle(backgroundColor: Color.white,
                                accentColor: Color.purple,
                                secondGradientColor: Color("Color11"),
                                textColor: Color(hex: "5AA5E2"), legendTextColor: Color(hex: "5AA5E2"), dropShadowColor: Color("Color5") )
    let chartStylee = ChartStyle(backgroundColor: Color.white,
                                 accentColor: Color("Color2"),
                                 secondGradientColor: Color("Color10"),
                                 textColor: Color(hex: "5AA5E2"), legendTextColor: Color(hex: "5AA5E2"), dropShadowColor: Color("Color5") )
    
    
    @State var selection: Int = 0
    @State var income: Double = 0.0
    
    
    @State private var selectedTab: Tab = .chartpie

       enum Tab {
           case dollarsign
           case chartpie
       }
   
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(hex: "F9F9FB")
                    .ignoresSafeArea()
                VStack{
                    
                    Spacer()
                        .frame(height:45)
                    Text("Overview")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 55)
                                .fill(Color(hex: "5AA5E2"))
                                .frame(width: 400, height: 200)
                                .ignoresSafeArea())
                    
                    
                    
                    Spacer()
                        .frame(height:55)
                    
                    VStack{
                        Picker(selection: $selection, label: Text("Options")){
                            Text("Weekly").tag(0)
                            Text("Monthly").tag(1)}
                        .pickerStyle(SegmentedPickerStyle())
                        .padding([.top,.horizontal],15)
                        
                        
                        
                        
                        
                    }
                    Spacer()
                        .frame(height:35)
                    
                    HStack {
                        if selection == 0 {
                            let weeklyNeedExpenses = viewModel.WeeklyNeedExpense()
                            let weeklyExpenses = viewModel.WeeklyExpense()
                            let combinedWeeklyExpenses = [("Sun", 50),
                                                          ("Mon", 200),
                                                          ("Tues", 0),
                                                          ("Wed", 2400),
                                                          ("Thurs", 0),
                                                          ("Fri", 0)]
                            
                            BarChartView(data: ChartData(values: combinedWeeklyExpenses), title: "Expenses", style: chartStyle)
                            
                            let weeklySavings = viewModel.WeeklySavings()
                            let combinedWeeklySavings = [("Sun", 20),
                                                         ("Mon", 10),
                                                         ("Tues", 60),
                                                         ("Wed", 500),
                                                         ("Thurs", 0),
                                                         ("Fri", 300)]
                            
                            BarChartView(data: ChartData(values: combinedWeeklySavings), title: "Saving", style: chartStylee)
                        } else if selection == 1 {
                            let monthlyNeedExpenses = viewModel.MonthlyNeedExpenses()
                            let monthlyExpenses = viewModel.MonthlyExpenses()
                            let combinedMonthlyExpenses = [("Jan", 2000),
                                                           ("Feb", 3000),
                                                           ("Mar",4000),
                                                           ("Apr", 2000),
                                                           ("May", 1800),
                                                           ("Jun", 3000),
                                                           ("Jul", 2000),
                                                           ("Aug", 2900)]
                            
                            BarChartView(data: ChartData(values: combinedMonthlyExpenses), title: "Expenses", style: chartStyle)
                            
                            let monthlySaving = viewModel.monthlySaving()
                            let combinedMonthlySavings = [("Jan", monthlySaving.January),
                                                          ("Feb", 500),
                                                          ("Mar", 700),
                                                          ("Apr", 400),
                                                          ("May", 500),
                                                          ("Jun", 1100),
                                                          ("Jul", 1000),
                                                          ("Aug",500)]
                            
                            BarChartView(data: ChartData(values: combinedMonthlySavings), title: "Saving", style: chartStylee)
                        }
                    }.padding([.top],20)
                        .padding([.bottom], 100)
                    
                    Spacer()
                        .padding([.bottom],50)
                    
                    
                    ZStack{
                        Rectangle()
                            .frame(width: 400,height: 100)
                            .foregroundColor(.white)
                            .ignoresSafeArea()
                        
                        HStack{
                            NavigationLink(destination: ContentView()){
                                
                                
                                
                                Image(systemName: "dollarsign.circle")
                                    .font(.title)
                                    .foregroundColor(Color(hex: "8F8F8F"))
                                    .padding(10)
                                
                            }
                            
                            Spacer()
                                .frame(width:150)
                            
                            
                            
                            
                            
                            Image(systemName: "chart.pie.fill")
                                .font(.title)
                                .foregroundColor(Color(hex: "5AA5E2"))
                                .padding(10)
                            
                        }.position(x:200,y:40)
                        
                        
                        
                        
                    }.padding(0)
                        .ignoresSafeArea()
                    
                }
                
            }
        }.navigationBarBackButtonHidden(true)
    }
    
}
//    struct statistics_Previews: PreviewProvider {
//        static var previews: some View {
//            statistics()
//        }
//    }

