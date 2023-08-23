//
//  OnBoardingView.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 23/01/1445 AH.
//


import SwiftUI

struct OnboardingView: View {
    var data: OnboardingData
    
    @State private var isAnimating: Bool = false
    @State private var showContentView: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                Image(data.objectImage)
                    .resizable()
                    .frame(width: 390.0, height: 380.0)
                    .scaledToFit()
                    .scaleEffect(isAnimating ? 1 : 0.9)
            }
            
            Spacer()
            
            Text(data.primaryText)
                .font(.title)
                .bold()
                .foregroundColor(Color(red: 0.353, green: 0.6470588235294118, blue: 0.8862745098039215))
            
            Text(data.secondaryText)
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(width: 350.0)
                .foregroundColor(Color(red: 0.5607843137254902, green: 0.5607843137254902, blue: 0.5607843137254902))
            
            Spacer()
            
            Button(action: {
                showContentView = true // Set state variable to true to trigger view presentation
            }, label: {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundColor(Color(red: 0.35294117647058826, green: 0.6470588235294118, blue: 0.8862745098039215))
                    )
            })
            .shadow(radius: 10)
            
            Spacer()
        }
        .onAppear(perform: {
            isAnimating = false
            withAnimation(.easeOut(duration: 0.5)) {
                self.isAnimating = true
            }
        })
        .fullScreenCover(isPresented: $showContentView, content: {
            ContentView()
        })
    }
}



/*
import SwiftUI


struct OnboardingView: View {
    var data: OnboardingData
    
    @State private var isAnimating: Bool = false
    
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
             
                
                
                Image(data.objectImage)
                    .resizable()
                    .frame(width: 390.0, height: 380.0)
                    .scaledToFit()
                //                    .offset(x: 0, y: 0)
                .scaleEffect(isAnimating ? 1 : 0.9)}
            
            
                          Spacer()
            //            Spacer()
            
                Text(data.primaryText)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(red: 0.353, green: 0.6470588235294118, blue: 0.8862745098039215))
                
                
                Text(data.secondaryText)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(width: 350.0)
                    .foregroundColor(Color(red: 0.5607843137254902, green: 0.5607843137254902, blue: 0.5607843137254902))
                
                Spacer()
                
                Button(action: {
                    // Add action for button
                }, label: {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 40)
                                .foregroundColor(Color(red: 0.35294117647058826, green: 0.6470588235294118, blue: 0.8862745098039215)
                                                )
                        )
                })
                .shadow(radius: 10)
                
                Spacer()
            }
            .onAppear(perform: {
                isAnimating = false
                withAnimation(.easeOut(duration: 0.5)) {
                    self.isAnimating = true
                }
            })
        }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(data: OnboardingData.list.first!)
    }
}*/
