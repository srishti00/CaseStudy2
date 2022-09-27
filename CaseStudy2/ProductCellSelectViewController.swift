//
//  ProductCellSelectViewController.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/24/22.
//

import UIKit

class ProductCellSelectViewController: UIViewController {

    //MARK: IBOutlet start
    
    @IBOutlet weak var selectedProductNameLabel: UILabel!
    @IBOutlet weak var selectedProductDecriptionLabel: UILabel!
    @IBOutlet weak var selectedProductRatingLabel: UILabel!
    @IBOutlet weak var selectedProductPriceLabel: UILabel!
    @IBOutlet weak var selectedProductDiscountLabel: UILabel!
    @IBOutlet weak var selectedProductBrandLabel: UILabel!
    @IBOutlet weak var selectedProductImageView: UIImageView!
    @IBOutlet weak var buyNowButtonLabel: UIButton!
    
    //MARK: IBOutlet end
    
    //MARK: Variables
    var productDetailsDict: NSDictionary = [:]
    var productImageArray: NSArray = []
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add to Cart"
        self.navigationItem.backBarButtonItem?.tintColor = .white
        
        //set text for all labels
        selectedProductNameLabel.text = productDetailsDict.value(forKey: "title") as? String
        selectedProductDecriptionLabel.text = productDetailsDict.value(forKey: "description") as? String
        selectedProductRatingLabel.text = "Rating:  \(productDetailsDict.value(forKey: "rating")!)"
        selectedProductPriceLabel.text = "Price:  $\(productDetailsDict.value(forKey: "price")!)"
        selectedProductDiscountLabel.text = "\(productDetailsDict.value(forKey: "discountPercentage")!)% discount"
        selectedProductBrandLabel.text = "Brand:  \(productDetailsDict.value(forKey: "brand") as? String ?? "")"
        productImageArray = productDetailsDict.value(forKey: "images") as! NSArray
        
        buyNowButtonLabel.layer.cornerRadius = 10
        
        animateProductImage()
    }
    
    //MARK: Animation Function
    
    //function to animate product images
    func animateProductImage() {
        for i in 0..<productImageArray.count {
            //get image from url
            if let imageData = try? Data(contentsOf: URL(string: productImageArray[i] as! String)!) {
                if let image = UIImage(data: imageData) {
                    images.append(image)
                }
            }
        }
        //set images and duration and start animation
        selectedProductImageView.animationImages = images
        selectedProductImageView.animationDuration = 8.0
        selectedProductImageView.startAnimating()
    }

    //MARK: IBAction
    
    //when add to cart button clicked
    @IBAction func addToCartButtonClicked(_ sender: Any) {
        let price = productDetailsDict.value(forKey: "price")
        let thumbnail = productDetailsDict.value(forKey: "thumbnail") as! String
        let id = productDetailsDict.value(forKey: "id")
        guard let userOfCart = currentUser else { return }
        
        //call function to insert record for current user in cart
        DBManager.sharedDBMangerInstance().insertRecordInCart(pID: id as! Int64, pName: selectedProductNameLabel.text!, pPrice: price as! Int64, pDescription: selectedProductDecriptionLabel.text!, pImageURL: thumbnail, user: userOfCart)
        
        //after storing data into core data navigate to cart view controller
        let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(cartVC, animated: true)
    }

    //when buy now button clicked
    @IBAction func buyNowButtonClicked(_ sender: Any) {
        //navigate to order view controller
        let orderVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        self.navigationController?.pushViewController(orderVC, animated: true)
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
