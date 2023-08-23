//
//  OnBoardingData.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 23/01/1445 AH.
//



import Foundation

struct OnboardingData: Hashable, Identifiable {
    let id: Int
//    let backgroundImage: String
    let objectImage: String
    let primaryText: String
    let secondaryText: String
//    let therdtext: String
    
//    let backgroundcolor: String

    static let list: [OnboardingData] = [
        OnboardingData(id: 0 , objectImage: "logo", primaryText: "Welcome to Spendly", secondaryText: "Take control of your money and save them by tracking your expenses" ),
        OnboardingData(id: 1, objectImage: "Savings", primaryText: "50/30/20 Strategy", secondaryText: "We'll help you take control of your finances with the 50/30/20 strategy. It's simple: just allocate 50% of your income to Needs, 30% to Wants, and 20% to Savings." ),
        OnboardingData(id: 2, objectImage: "goal", primaryText: "Goal of 50/30/20", secondaryText: "This rule is easy to follow, provides clarity, flexibility, and balance, and will help you reach your financial goals in no time. Let's get started!" )
    ]
}
