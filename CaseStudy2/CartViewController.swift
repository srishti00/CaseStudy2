//
//  CategoryCellSelectViewController.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/23/22.
//

import UIKit

//MARK: Table View Cell Class

class CartTableViewCell: UITableViewCell {
    
    //MARK: IBOutlet start
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    //MARK: IBOutlet end
}

//MARK: View Controller Class

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: IBOutlets
    
    @IBOutlet weak var cartTableView: UITableView!
    
    //MARK: Variables
    
    var cartProductArray: [Cart] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.title = "Cart"
        
        //fetch cart data for current user
        if currentUser?.toCart?.allObjects != nil {
            cartProductArray = currentUser?.toCart?.allObjects as! [Cart]
        }
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.reloadData()
    }
    
    //MARK: Table view delegate functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProductArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        
        let cartProduct = cartProductArray[indexPath.row]
        
        //set cell labels field
        cell.productNameLabel.text = cartProduct.productName
        cell.productPriceLabel.text = "Price: $\(cartProduct.productPrice)"
        cell.productDescriptionLabel.text = cartProduct.productDescription
        if let imageData = try? Data(contentsOf: URL(string: cartProduct.productImage!)!) {
            if let loadedImage = UIImage(data: imageData) {
                cell.productImageView.image = loadedImage
            }
        }
        cell.orderButton.tag = indexPath.row
        cell.orderButton.addTarget(self, action: #selector(orderButtonClicked(sender: )), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(sender: )), for: .touchUpInside)
        
        return cell
    }
    
    //MARK: Selector functions
    
    //when order button clicked
    @objc func orderButtonClicked(sender: UIButton) {
        //get current row index
        let rowIndexPath = IndexPath(row: sender.tag, section: 0)
        let cartProductID = cartProductArray[rowIndexPath.row].productID
        //set selected product ID
        productId = cartProductID
        
        //navigate to order view controller
        let orderVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        self.navigationController?.pushViewController(orderVC, animated: true)
    }
    
    //when delete button clicked
    @objc func deleteButtonClicked(sender: UIButton) {
        //get current row index
        let rowIndexPath = IndexPath(row: sender.tag, section: 0)
        let cartProductID = cartProductArray[rowIndexPath.row].productID
        
        //delete product data from cart for selected product
        DBManager.sharedDBMangerInstance().deleteProductFromCart(pID: cartProductID)
        
        //remove from array
        cartProductArray.remove(at: rowIndexPath.row)
        
        cartTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
