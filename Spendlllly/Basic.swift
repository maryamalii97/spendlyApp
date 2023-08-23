//
//  Basic.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 23/01/1445 AH.
//
import SwiftUI

struct Basic: View {
    @State private var currentTab = 0

    var body: some View {
        TabView(selection: $currentTab,
                content:  {
                    ForEach(OnboardingData.list) { viewData in
                        OnboardingView(data: viewData)
                            .tag(viewData.id)
                    }     
                })
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}
struct Basic_Previews: PreviewProvider {
    static var previews: some View {
        Basic()
    }
}
