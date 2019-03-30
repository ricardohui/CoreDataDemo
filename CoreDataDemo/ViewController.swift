//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Ricardo Hui on 30/3/2019.
//  Copyright © 2019 Ricardo Hui. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName:"Users", into: context)
        newUser.setValue("Ricardo",forKey:"username")
        newUser.setValue("myPass", forKey: "password")
        newUser.setValue(2, forKey: "age")
        
        do {
            try context.save()
            print("Saved")
        } catch  {
            print("There was an error")
        }
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.predicate = NSPredicate(format: "age < %@", "10")
        
        
        
        
        
        request.returnsObjectsAsFaults = false
        do {
        let results =  try context.fetch(request)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    if let username = result.value(forKey: "username") as? String{
                        print(username)
                        context.delete(result) // delete an object
                        
                    }
                }
            }else{
                print("No result")
            }
        } catch {
            print("Couldn't fetch results")
        }
    }


}

