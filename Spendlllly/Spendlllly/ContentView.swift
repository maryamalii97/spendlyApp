//
//  ContentView.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 21/01/1445 AH.
//




import SwiftUI
import CoreData

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let g = Double((rgbValue & 0xff00) >> 8) / 255.0
        let b = Double(rgbValue & 0xff) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}



//change needSpend, wantSpend, savingSpend to sum of logs

struct ContentView: View {
    @State private var selectedTab: Tab = .dollarsign

       enum Tab {
           case dollarsign
           case chartpie
       }
    
 @State private var needam :Double = 0
 @State private var wantam :Double = 0
    @State private var saveam :Double = 0.0
    @State private var income: Double = 0.0
    @State private var needsPercentage: Int = 0
    @State private var wantsPercentage: Int = 0
    @State private var savingsPercentage: Int = 0
    @State  var Currency = "SAR"
    @State  var Needs = 50
    
    @ObservedObject var viewModel : WantViewModel
    
    @State private var WantSpend = 0.0
    @State  var NeedSpend = 0.0
    @State private var Savingspend = 0.0
   
    init() {
        self.viewModel = WantViewModel()
        viewModel.fetchWantsData(category:"Need")
        viewModel.fetchWantsData(category:"Want")
        viewModel.fetchWantsData(category:"Saving")
        NeedSpend = -viewModel.needmonthlytotal()
        WantSpend = -viewModel.wantmonthlytotal()
        Savingspend = viewModel.savingmonthlytotal()
        //viewModel.createDummyDate()
    }
   
    
    
    private var needsprogress: Float {
        if(needam == 0 ){
            return Float(0)
        }else  if(NeedSpend < 0 ){
            return Float(0)
        }else if(NeedSpend <= needam){
       return Float(NeedSpend)/Float(needam)
            
        }else {
            
            return Float(needam)/Float(needam)
            
           }
    
   
    }
    
    
    @State private var Wants = 50
   
    
 private var wantsprogress: Float {
     if(wantam == 0 ){
         return Float(0)
     }else  if(WantSpend < 0 ){

         return Float(0)
     }else if(WantSpend <= wantam){

   return Float(WantSpend)/Float(wantam)
         
     }else {

         return Float(wantam)/Float(wantam)
         
        }
 
    }
    @State private var Savings = 50
    
    
 private var savingsprogress: Float {
  
     if(saveam == 0 ){
         return Float(0)
     }else  if(Savingspend < 0 ){
        
         return Float(0)
     }else if(Savingspend <= saveam){
        return Float(Savingspend)/Float(saveam)
         
     }else {
         return Float(saveam)/Float(saveam)
         
        }
    }
    
   

    
   
    
    var body: some View {
        
        NavigationView {
            ZStack{
                Color(hex: "F9F9FB")
                    .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: 55)
                    .fill(Color(hex: "5AA5E2"))
                    .frame(width: 420, height: 289)
                    .position(x:195,y:144)
                    .ignoresSafeArea()
                VStack(spacing: 9){
                    HStack{
                        
                        NavigationLink(destination: logExpense(viewModel: viewModel)){

                            Spacer()
                             
                                Image(systemName: "plus.app")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(20)}
                    
                       
                        
                        
                    }
                    
                    Text("Income")
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .fontWeight(.semibold)
                    
                    ZStack{
                        
                        Text("\(income, specifier: "%.2f")")
                            .font(.title)
                            .frame(width: 257, height: 48)
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                Rectangle()
                                    .fill(Color.white)
                                    .opacity(0.4)
                                    .cornerRadius(24)
                                    .frame(width: 257, height: 48)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color.white, lineWidth: 1)
                                        
                                    )
                            )
                        HStack{
                            Spacer()
                                                 
                            NavigationLink(destination:  FinalS(income: $income ,needsPercentage: $needsPercentage, wantsPercentage: $wantsPercentage, savingsPercentage: $savingsPercentage, needam: $needam, wantam: $wantam, saveam: $saveam )){
                                Image(systemName: "pencil.circle")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }.padding(10)
                        }.frame(width: 257, height: 48)
                            }





                    NavigationLink(destination: NeedsHistory(viewModel: viewModel)){

                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .frame(width: 345, height: 131)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Add a shadow to the rectangle
                            
                            VStack{
                                HStack{
                                    
                                    Text("Needs")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                    Spacer()
                                    Text("\(needsPercentage)%")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                }
                                Spacer()
                                
                                ZStack (alignment: .leading) {
                                    ZStack (alignment: .trailing){
                                        Rectangle()
                                            .foregroundColor(Color(hex: "F9F9FB"))
                                        Text(" \(needam, specifier: "%.2f") \(Currency)")
                                            .foregroundColor(Color(hex: "5AA5E2"))
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                    }
                                    ZStack (alignment: .leading){
                                        RoundedRectangle(cornerRadius: 23)
                                      .foregroundColor( Color(hex: "FFA528")).opacity(0.9)
                                            .frame(width: CGFloat(needsprogress) * 300, height: 44)
                                            //.frame(width:1 ,height:200)
                                            
                                          
                                        
                                        Text(" \(NeedSpend, specifier: "%.2f") \(Currency)")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                    }
                                }
                                .frame(height: 44)
                                .cornerRadius(23)
                                
                                
                            }.frame(width: 280, height: 90)
                            
                            
                        }
                    }
                    ///
                    ///
                    NavigationLink(destination: WantsHistory(viewModel: viewModel)){

                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .frame(width: 345, height: 131)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Add a shadow to the rectangle
                            
                            VStack{
                                HStack{
                                    
                                    Text("Wants")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                    Spacer()
                                    Text("\(wantsPercentage)%")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                }
                                Spacer()
                                
                                ZStack (alignment: .leading) {
                                    ZStack (alignment: .trailing){
                                        Rectangle()
                                            .foregroundColor(Color(hex: "F9F9FB"))
                                        Text(" \(wantam, specifier: "%.2f") \(Currency)")
                                            .foregroundColor(Color(hex: "5AA5E2"))
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                    }
                                    ZStack (alignment: .leading){
                                        RoundedRectangle(cornerRadius: 23)
                                            .foregroundColor( Color(hex: "A981E9")).opacity(0.9)
                                            .frame(width: CGFloat(wantsprogress) * 300, height: 44)
                                           // .frame(width:20 ,height:200)
                                        Text(" 1500.00 \(Currency)")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                    }
                                }
                                .frame(height: 44)
                                .cornerRadius(23)
                                
                                
                            }.frame(width: 280, height: 90)
                            
                            
                            
                        }
                    }
                    ///
                    NavigationLink(destination: SavingsHistory(viewModel: viewModel)){

                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .frame(width: 345, height: 131)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Add a shadow to the rectangle
                            
                            VStack{
                                HStack{
                                    
                                    Text("Savings")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                    Spacer()
                                    Text("\(savingsPercentage)%")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                }
                                Spacer()
                                
                                ZStack (alignment: .leading) {
                                    ZStack (alignment: .trailing){
                                        Rectangle()
                                            .foregroundColor(Color(hex: "F9F9FB"))
                                        Text(" \(saveam, specifier: "%.2f") \(Currency)")
                                            .foregroundColor(Color(hex: "5AA5E2"))
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                    }
                                    ZStack (alignment: .leading){
                                        RoundedRectangle(cornerRadius: 23)
                                            .foregroundColor( Color(hex: "6DB388")).opacity(0.9)
                                            .frame(width: CGFloat(savingsprogress) * 300, height: 44)
                                            //.frame(width:20 ,height:200)
                                         
                                        Text(" \(Savingspend, specifier: "%.2f") \(Currency)")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                     
                                    }
                                }
                                .frame(height: 44)
                                .cornerRadius(23)
                                
                                
                            }.frame(width: 280, height: 90)
                            
                            
                        }
                    }
                  ///
                    
                    Spacer()
                        .frame(width: 257, height: 66)
                 
                    
                    ZStack{
                        Rectangle()
                            .frame(width: 400,height: 100)
                            .foregroundColor( .white)
                        
                        HStack{
                         
                               
                                
                                    Image(systemName: "dollarsign.circle")
                                        .font(.title)
                                        .foregroundColor(Color(hex: "5AA5E2"))
                                        .padding(10)
                                
                            
                            Spacer()
                                .frame(width:150)
                            
                            

                            NavigationLink(destination: statistics(viewModel: viewModel)){
                                
                                Image(systemName: "chart.pie.fill")
                                    .font(.title)
                                    .foregroundColor(Color(hex: "8F8F8F"))
                                    .padding(10)
                            }
                       
                        }.position(x:200,y:40)
                        
                        
                        
                        
                    }.padding(0)
                        .ignoresSafeArea()
                }//vstack
               
            }//zstack
           
            
        }.navigationBarBackButtonHidden(true)
            .onAppear(){
                viewModel.fetchWantsData(category:"Need")
                viewModel.fetchWantsData(category:"Want")
                viewModel.fetchWantsData(category:"Saving")
                NeedSpend = -viewModel.needmonthlytotal()
                WantSpend = -viewModel.wantmonthlytotal()
                Savingspend = viewModel.savingmonthlytotal()
               
            }
    }
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}








/*

import SwiftUI
import CoreData

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let g = Double((rgbValue & 0xff00) >> 8) / 255.0
        let b = Double(rgbValue & 0xff) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}



struct ContentView: View {
   
    @ObservedObject var viewModel : WantViewModel

    
    @State private var Currency = "SAR"
    @State private var Needs = 500
    @State private var NeedSpend = 200
    private var needsprogress: Float {
        
        return Float(NeedSpend)/Float(Needs)
    }
    
    
    @State private var Wants = 300
    @State private var WantSpend = 200
    private var wantsprogress: Float {
        
        return Float(WantSpend)/Float(Wants)
    }
    @State private var Savings = 200
    @State private var Savingspend = 150
    private var savingsprogress: Float {
        
        return Float(Savingspend)/Float(Savings)
    }
    
    
    init() {
        self.viewModel = WantViewModel()
        viewModel.fetchWantsData(category:"Need")
        viewModel.fetchWantsData(category:"Want")
        viewModel.fetchWantsData(category:"Saving")

    }
    
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(hex: "F9F9FB")
                    .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: 55)
                    .fill(Color(hex: "5AA5E2"))
                    .frame(width: 395, height: 289)
                    .position(x:195,y:144)
                    .ignoresSafeArea()
                VStack(spacing: 9){
                    HStack{
                        
                        NavigationLink(destination: logExpense(viewModel: WantViewModel())){
                            
                            
                            Image(systemName: "plus.app")
                                .font(.title)
                                .foregroundColor(.white)
                            .padding(10)}
                        Spacer()
                        
                    }
                    
                    Text("Income")
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .fontWeight(.semibold)
                    
                    ZStack{
                        
                        Text("0 SAR")
                            .font(.title)
                            .frame(width: 257, height: 48)
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                Rectangle()
                                    .fill(Color.white)
                                    .opacity(0.4)
                                    .cornerRadius(24)
                                    .frame(width: 257, height: 48)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color.white, lineWidth: 1)
                                    )
                            )
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                // action to perform when button is tapped
                            }) {
                                Image(systemName: "pencil.circle")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }.padding(10)
                            
                        }.frame(width: 257, height: 48)
                        
                    }
                    
                    ///
                    NavigationLink(destination: NeedsHistory(viewModel: viewModel)){
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .frame(width: 345, height: 131)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Add a shadow to the rectangle
                            
                            VStack{
                                HStack{
                                    
                                    Text("Needs")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                    Spacer()
                                    Text("50%")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                }
                                Spacer()
                                
                                ZStack (alignment: .leading) {
                                    ZStack (alignment: .trailing){
                                        Rectangle()
                                            .foregroundColor(Color(hex: "F9F9FB"))
                                        Text(" \(Needs) \(Currency)")
                                            .foregroundColor(Color(hex: "5AA5E2"))
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                    }
                                    ZStack (alignment: .leading){
                                        RoundedRectangle(cornerRadius: 23)
                                            .foregroundColor( Color(hex: "FFA528"))
                                            .frame(width: CGFloat(needsprogress) * 300, height: 44)
                                        Text(" \(NeedSpend) \(Currency)")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                    }
                                }
                                .frame(height: 44)
                                .cornerRadius(23)
                                
                                
                            }.frame(width: 280, height: 90)
                            
                            
                        }
                    }
                    ///
                    ///
                    NavigationLink(destination: WantsHistory(viewModel: viewModel)){
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .frame(width: 345, height: 131)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Add a shadow to the rectangle
                            
                            VStack{
                                HStack{
                                    
                                    Text("Wants")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                    Spacer()
                                    Text("30%")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                }
                                Spacer()
                                
                                ZStack (alignment: .leading) {
                                    ZStack (alignment: .trailing){
                                        Rectangle()
                                            .foregroundColor(Color(hex: "F9F9FB"))
                                        Text(" \(Wants) \(Currency)")
                                            .foregroundColor(Color(hex: "5AA5E2"))
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                    }
                                    ZStack (alignment: .leading){
                                        RoundedRectangle(cornerRadius: 23)
                                            .foregroundColor( Color(hex: "A981E9"))
                                            .frame(width: CGFloat(wantsprogress) * 300, height: 44)
                                        Text(" \(WantSpend) \(Currency)")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                    }
                                }
                                .frame(height: 44)
                                .cornerRadius(23)
                                
                                
                            }.frame(width: 280, height: 90)
                            
                            
                            
                        }
                    }
                    ///
                    NavigationLink(destination: SavingsHistory(viewModel: viewModel)){
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .frame(width: 345, height: 131)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Add a shadow to the rectangle
                            
                            VStack{
                                HStack{
                                    
                                    Text("Savings")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                    Spacer()
                                    Text("20%")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .fontWeight(.thin)
                                    
                                }
                                Spacer()
                                
                                ZStack (alignment: .leading) {
                                    ZStack (alignment: .trailing){
                                        Rectangle()
                                            .foregroundColor(Color(hex: "F9F9FB"))
                                        Text(" \(Savings) \(Currency)")
                                            .foregroundColor(Color(hex: "5AA5E2"))
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                    }
                                    ZStack (alignment: .leading){
                                        RoundedRectangle(cornerRadius: 23)
                                            .foregroundColor( Color(hex: "6DB388"))
                                            .frame(width: CGFloat(savingsprogress) * 300, height: 44)
                                        Text(" \(Savingspend) \(Currency)")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18))
                                            .fontWeight(.thin)
                                            .padding(10)
                                    }
                                }
                                .frame(height: 44)
                                .cornerRadius(23)
                                
                                
                            }.frame(width: 280, height: 90)
                            
                            
                        }
                    }
                    ///
                    
                    Spacer()
                    NavigationLink(destination: statistics(viewModel: viewModel)) {
                        Text("sat")
                            .foregroundColor(.red)
                    }
                    
                }
                
            }
        }.navigationBarBackButtonHidden(true)
       
    }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

*/
