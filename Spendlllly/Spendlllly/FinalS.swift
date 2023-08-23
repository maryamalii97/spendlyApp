//
//  FinalS.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 27/01/1445 AH.
//

import SwiftUI
import UIKit

struct FinalS: View {
    @State private var isShowingChildView = false

    @Binding var income: Double
    @Binding var needsPercentage: Int
    @Binding var wantsPercentage: Int
    @Binding var savingsPercentage: Int
    @Binding var needam :Double
    @Binding var wantam :Double
    @Binding var saveam :Double
    
    @State var numm = 0
    func change(){
        numm=1
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Sblue")
                    .ignoresSafeArea()
                VStack{
                    ZStack{
                        Text("Income")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                            .frame(width:150)
                            .padding(.top, 27)
                        
                        HStack(){
                            Spacer()
                        }.frame(width: 340)//end of Hstack
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 28)
                            .frame(width:400 , height:650)
                            .foregroundColor(.white)
                            .frame(maxHeight:
                                    .infinity,
                                   alignment:.bottom)
                            .ignoresSafeArea()
                        VStack{
                            Form{
                                VStack{
                                    HStack{
                                        Text(" Income :")
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("Dark grey"))
                                        Spacer()
                                    }
                                    
                                    TextField("Enter your income ", value: $income, format:.currency(code: ""))
                                        .keyboardType(.decimalPad)
                                        .foregroundColor(.black)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(height: 45)
                                        .shadow(radius: 0.5)
                                    Spacer()
                                }
                            }.background(.white)
                                .scrollContentBackground(.hidden)
                                .cornerRadius(28)
                                .frame(height: 114)
                            
                            Form{
                                
                                Label("Division of income ", systemImage: "")
                                    .foregroundColor(Color("Dark grey"))
                                    .padding(.trailing ,30)
                                    .frame(width: 350,height: 37)
                                    .background(Color("light grey"))
                                    .cornerRadius(8)
                                    .fontWeight(.medium)
                                    .shadow(radius:0.5)
                                Spacer()
                            }.background(.white)
                                .scrollContentBackground(.hidden)
                                .frame(height: 85)
                            
                            
                            Form{
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 250)
                                            .foregroundColor(Color("Sorange"))
                                        HStack{
                                            Text("Needs")
                                                .foregroundColor(.white)
                                                .frame(width: 50)
                                                .padding(.trailing,30)
                                            
                                            Text("\(needam, specifier: "%.2f")")
                                                .foregroundColor(.white)
                                                .padding(.leading,30)
                                        }//end of Hstack
                                    }.frame(height: 38)
                                    
                                    Picker(
                                        selection: $needsPercentage
                                        ,label: Text("%")
                                            .padding(.leading,10)
                                        
                                        ,content: {
                                            ForEach([0,5,10,15, 20,25, 30,35, 40,45, 50,55, 60,65, 70,75, 80,85, 90,95,100], id: \.self) { num in
                                                Text(" \(num)")
                                                   
                                                    .tag("\(num)")
                                            }
                                        }).foregroundColor(.white)
                                        .frame(width:85,height: 38)
                                        .background(Color("Sorange"))
                                        .cornerRadius(8)
                                        .onChange(of: needsPercentage) { newValue in
                                            validatePickerValues()
                                        }
                                }.shadow(radius:1)//end of Hstack
                                
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 250)
                                            .foregroundColor(Color("Sviolete"))
                                        
                                        HStack{
                                            Text("Wants")
                                                .foregroundColor(.white)
                                                .frame(width: 50)
                                                .padding(.trailing,30)
                                            
                                            Text("\(wantam, specifier: "%.2f")")
                                                .foregroundColor(.white)
                                                .padding(.leading,30)
                                        }//end of Hstack
                                    }.frame(height: 38)
                                    
                                    Picker(
                                        selection: $wantsPercentage
                                        ,label: Text("%")
                                            .padding(.leading,10)
                                        ,content: {
                                            ForEach([0,5,10,15, 20,25, 30,35, 40,45, 50,55, 60,65, 70,75, 80,85, 90,95,100], id: \.self) { num in
                                                Text("\(num)")
                                                    .tag("\(num)")
                                            }
                                        }).frame(width: 85,height: 38)                       .background(Color("Sviolete"))
                                        .cornerRadius(8)
                                        .foregroundColor(.white)
                                        .onChange(of: wantsPercentage) { newValue in
                                            validatePickerValues()}
                                }.shadow(radius:1)//end of Hstack
                                
                                
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 250)
                                            .foregroundColor(Color("Sgreen"))
                                        
                                        HStack{
                                            Text("Savings")
                                                .foregroundColor(.white)
                                                .frame(width: 60)
                                                .padding(.trailing,30)
                                            
                                            Text("\(saveam, specifier: "%.2f")")
                                                .foregroundColor(.white)
                                                .padding(.leading,30)
                                        }//end of Hstack
                                    }.frame(height: 38)
                                    
                                    Picker(
                                        selection: $savingsPercentage
                                        ,label: Text("%")
                                            .padding(.leading,10)
                                        ,content: {
                                            ForEach([0,5,10,15, 20,25, 30,35, 40,45, 50,55, 60,65, 70,75, 80,85, 90,95,100], id: \.self) { num in
                                                Text("\(num)")
                                                    .tag("\(num)")
                                            }
                                        }).frame(width: 85,height: 38)                       .background(Color("Sgreen"))
                                        .cornerRadius(8)
                                        .foregroundColor(.white)
                                        .onChange(of:savingsPercentage) { newValue in
                                            
                                            validatePickerValues()}
                                }.shadow(radius:1)//end of Hstack
                                
                            }.frame(height: 205)
                                .padding(.bottom,20)
                                .background(.white)
                                .scrollContentBackground(.hidden)
                            //end of main the form
                            
                            
                            Button("Done") {
                                
                                needam = Double((Double(needsPercentage)/100) * income)
                                wantam = Double((Double(wantsPercentage)/100) * income)
                                saveam = Double((Double(savingsPercentage)/100) * income)
                                
                            }.frame(width: 200, height: 40)
                                .buttonStyle(.borderless)
                                .foregroundColor(.white)
                                .background(Color("Sblue"))
                                .cornerRadius(22)
                                .frame(height: 70)
                                .shadow(radius:1)
                            
                            Button(" Use (50/30/20) "){
                                
                                needsPercentage = 50
                                wantsPercentage = 30
                                savingsPercentage = 20
                                
                                needam = Double((Double(needsPercentage)/100) * income)
                                wantam = Double((Double(wantsPercentage)/100) * income)
                                saveam = Double((Double(savingsPercentage)/100) * income)
                                
                            }.frame(width: 200, height: 40)
                                .buttonStyle(.borderless)
                                .foregroundColor(.white)
                                .background(Color("Sblue"))
                                .cornerRadius(22)
                                .frame(height: 20)
                                .shadow(radius:1)
                            
                            
                            Spacer()
                        }.frame(height: 600)
                            .padding(.bottom,30)
                    }
                }//main Vstack
                
            }
            //end of Zstack
            
            
        }// end of the navegation view
       
  
    }//end of body
    
    
    func validatePickerValues(){
//
        let total = needsPercentage + wantsPercentage + savingsPercentage
        if total > 100 {
            // Adjust the values to make the sum equal to 100
            let difference = total - 100
            if needsPercentage > difference {
                needsPercentage -= difference
            } else if wantsPercentage > difference {
                wantsPercentage -= difference
            } else if savingsPercentage > difference {
                savingsPercentage -= difference
            }
        } else if total < 100 {
            // Adjust the values to make the sum equal to 100
            let difference = 100 - total
            if needsPercentage < 100 {
                needsPercentage += difference
            } else if wantsPercentage < 100 {
                wantsPercentage += difference
            } else if savingsPercentage < 100 {
                savingsPercentage += difference
            }
        }
    }//end of validatePickerValues function
    
    
}



struct FinalS_Previews: PreviewProvider {
    static var previews: some View {
        FinalS(income: .constant(0.0) ,needsPercentage: .constant(0), wantsPercentage: .constant(0), savingsPercentage: .constant(0), needam: .constant(0.0), wantam: .constant(0.0), saveam: .constant(0.0))
    }
    
    
}

struct ChildView: View {
    @Binding var isShowingChildView: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                isShowingChildView = false
            }) {
                Text("Budget")
                 .foregroundColor(.white) // Set the color of the back button text
                 .font(.system(size: 20))
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
            }
            
            // Other child view content...
        }
    }
}
