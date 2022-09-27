//
//  CartViewController.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/22/22.
//

import UIKit
import Alamofire

//MARK: Table view cell class

class ProductTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets for table view cell
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
}

class CategoryCellSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: IBOutlets for view controller
    
    @IBOutlet weak var productTableView: UITableView!
    
    //MARK: Variables
    
    var productArray: NSArray = []
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        self.navigationItem.title = "Products"
        self.navigationItem.backBarButtonItem?.tintColor = .white
        getProduct()
    }
    
    //MARK: JSON Parsing function
    
    func getProduct() {
        //alamofire used to parse json data from given url which is coming from previous controller
        Alamofire.request(self.url, method: .get).responseJSON(completionHandler: {
            response in
            
            //switch for success or failure while parsing
            switch response.result {
                case .success:
                    let json = response.result.value as! NSDictionary
                    //get data for only product key
                    self.productArray = json.value(forKey: "products") as! NSArray

                    DispatchQueue.main.async {
                        self.productTableView.delegate = self
                        self.productTableView.dataSource = self
                        self.productTableView.reloadData()
                    }
                case .failure(let error):
                    self.showAlert(msg: "Some error occured \(error)")
            }
        })
    }
    
    //MARK: Table view delegate functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.productTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        
        let product = productArray[indexPath.row] as! NSDictionary
        
        //set all label field
        cell.productNameLabel.text = product.value(forKey: "title") as? String
        cell.productDescription.text = product.value(forKey: "description") as? String
        cell.productDescription.sizeToFit()
        let price = product.value(forKey: "price")!
        cell.productPriceLabel.text = "Price: $\(price )"
        let url = URL(string: (product.value(forKey: "thumbnail") as! String))
        if let imageData = try? Data(contentsOf: url!) {
            if let loadedImage = UIImage(data: imageData) {
                cell.productImageView.image = loadedImage
            }
        }
        cell.addToCartButton.tag = indexPath.row
        cell.addToCartButton.addTarget(self, action: #selector(addToCartButtonClicked), for: .touchUpInside)
        return cell
    }
    
    //MARK: Selector function
    
    //when add to cart b utton clicked
    @objc func addToCartButtonClicked(sender: UIButton) {
        //get current row index
        let rowIndexPath = IndexPath(row: sender.tag, section: 0)
        
        //get data for slelected product
        let product = productArray[rowIndexPath.row] as! NSDictionary
        let productID = product.value(forKey: "id") as! Int64
        let productName = product.value(forKey: "title") as! String
        let productPrice = product.value(forKey: "price") as! Int64
        let productDescription = product.value(forKey: "description") as! String
        let productImageUrl = product.value(forKey: "thumbnail") as! String
        guard let userOfCart = currentUser else { return }
        
        //store selected product data in cart entity
        DBManager.sharedDBMangerInstance().insertRecordInCart(pID: productID, pName: productName, pPrice: productPrice, pDescription: productDescription, pImageURL: productImageUrl, user: userOfCart)
        
        //navigate to cart view controller
        let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navigate to product cell select view controller
        let productVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductCellSelectViewController") as! ProductCellSelectViewController
        self.navigationController?.pushViewController(productVC, animated: true)
        productVC.productDetailsDict = productArray[indexPath.row] as! NSDictionary
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
