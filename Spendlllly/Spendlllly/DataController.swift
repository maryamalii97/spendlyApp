//
//  DataController.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 22/01/1445 AH.
//
import CoreData
import Foundation

class DataController: ObservableObject{
    let container=NSPersistentContainer(name: "Spendlly")
    static let shared = DataController()
    
    init(){
        container.loadPersistentStores{ desciptoin, error in
            if let error = error {
                print("core data failed to laod:\(error.localizedDescription)")
            }
        }
        
       
    }
    
}
