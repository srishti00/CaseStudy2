//
//  DBManager.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/22/22.
//

import Foundation
import CoreData

class DBManager: NSObject {
    
    let managerContextObject = AppDelegate.sharedAppDelegateInstance().persistentContainer.viewContext
    
    //to get DBManager instance
    class func sharedDBMangerInstance() -> DBManager {
        struct Singleton {
            static let sharedInstance = DBManager()
        }
        return Singleton.sharedInstance
    }
    
    //MARK: Insert user data
    
    //it will insert user data in core data
    func insertRecordInUser(uName: String, uEmail: String, uMobile: Int64, uPassword: String) {
        let user = User(context: managerContextObject)
        user.userName = uName
        user.userEmailId = uEmail
        user.userMobile = uMobile
        user.userPassword = uPassword
        do {
            try managerContextObject.save()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Fetch data for specific user
    
    //it will fetch user data for specific user from core data
    func fetchRecordFromUser(uID: String) -> User? {
        var user: User?
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "userEmailId == %@", uID)
        fetchRequest.predicate = predicate
        do {
            let userArray = try managerContextObject.fetch(fetchRequest)
            for i in 0..<userArray.count {
                user = userArray[i]
            }
        } catch (let error) {
            print(error.localizedDescription)
        }
        return user
    }
    
    //MARK: Fetch data for all users
    
    //it will fetch whole user data from core data and return user array
    func fetchRecord() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
       
        do {
            let userArray = try managerContextObject.fetch(fetchRequest)
            return userArray
        } catch (let error) {
            print(error.localizedDescription)
            fatalError("failed")
        }
  
    }
    
    //MARK: Insert Cart data
    
    //it will insert cart data into core data
    func insertRecordInCart(pID: Int64, pName: String, pPrice: Int64, pDescription: String, pImageURL: String, user: User ) {
        let product = Cart(context: managerContextObject)
        product.productName = pName
        product.productPrice = pPrice
        product.productDescription = pDescription
        product.productImage = pImageURL
        product.productID = pID
        product.ofUser = user
        
        do {
            try managerContextObject.save()
            print("Store successfully")
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Fetch all cart data
    
    //It will fetch all data for cart and return cart array
    func fetchRecordFormCart() -> [Cart] {
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let productArray = try managerContextObject.fetch(fetchRequest)
            return productArray
        } catch (let error) {
            print(error.localizedDescription)
            fatalError("failed")
        }
    }
    
    //MARK: Delete a specific product from cart
    
    //It will take product id and delete its data from core data
    func deleteProductFromCart(pID: Int64) {
        let request: NSFetchRequest<Cart> = Cart.fetchRequest()
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "productID == %d", pID)
        request.predicate = predicate
        do {
            let productArray = try managerContextObject.fetch(request)
            for i in 0..<productArray.count {
                managerContextObject.delete(productArray[i])
            }
            do {
                try managerContextObject.save()
            } catch (let error) {
                print(error.localizedDescription)
            }
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
}
