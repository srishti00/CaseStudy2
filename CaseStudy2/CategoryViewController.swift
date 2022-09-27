//
//  CategoryViewController.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/22/22.
//

import UIKit
import Alamofire

//MARK: Table view cell class

class CategoryTabelViewCell: UITableViewCell {
 
    @IBOutlet weak var categoryLabel: UILabel!
}

//MARK: View Controller class

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: IBOutlets
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    //MARK: IBAction
    
    var categoryArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        parsingCategoryJsonFile()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.title = "Category"
    }
    
    //MARK: Json parsing function
    
    func parsingCategoryJsonFile(){
        //get json data from given url with the help of alamofire
        Alamofire.request("https://dummyjson.com/products/categories", method: .get).responseJSON {
            response in
            //switch for success and failure while parsing data
            switch response.result {
            case .success:
                if let json = response.result.value {
                    self.categoryArray = json as! [String]
                }
                DispatchQueue.main.async {
                    self.categoryTableView.delegate = self
                    self.categoryTableView.dataSource = self
                    self.categoryTableView.reloadData()
                }
            case .failure(let error):
                self.showAlert(msg: "Some error occured \(error)")
            }
        }
    }
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.categoryTableView.dequeueReusableCell(withIdentifier: "CategoryTabelViewCell", for: indexPath) as! CategoryTabelViewCell
        cell.categoryLabel.text = categoryArray[indexPath.row] 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categoryArray[indexPath.row]
        
        //navigate to category cell select view controller
        let productVC = self.storyboard?.instantiateViewController(withIdentifier: "CategoryCellSelectViewController") as! CategoryCellSelectViewController
        self.navigationController?.pushViewController(productVC, animated: true)
        productVC.url = "https://dummyjson.com/products/category/" + category
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
