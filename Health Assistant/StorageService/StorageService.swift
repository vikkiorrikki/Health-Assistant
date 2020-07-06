//
//  StorageService.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 02.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit
import CoreData

class StorageService {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addDoctor() {
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Doctor",
                                       in: context)!
        
//        let doctor = NSManagedObject(entity: entity,
//                                      insertInto: context)
        
//        doctor.setValue(specialization, forKeyPath: "specialization") //should we add values in this methods or in DoctorPresenter?
//        doctor.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func loadDoctors() -> [Doctor] {
        
    }
    
    func loadEvents(doctorID: Int) {
        
    }
    
    func addEvent() {
        
    }
    
    func updateEvent() {
        
    }
    
    //delete will be as remove -> save to context?
}
