//
//  Splash.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 23/01/1445 AH.
//
import SwiftUI

struct Splash: View {
    @State var isActive: Bool = false

    var body: some View {
       
        ZStack {
                   if self.isActive {
                       Basic()
                   } else {
                       Image("SPENDLY")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 350, height: 350)
                   }
               }
               .onAppear {
                   DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                       withAnimation {
                           self.isActive = true
                       }
                   }
               }
        
        
    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
