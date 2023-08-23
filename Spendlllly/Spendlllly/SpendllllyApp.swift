//
//  SpendllllyApp.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 21/01/1445 AH.
//

import SwiftUI

@main
struct SpendllllyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
Splash()
            //Basic()
             .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
