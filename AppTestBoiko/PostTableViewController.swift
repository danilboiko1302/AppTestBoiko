//
//  PostTableViewController.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 14.11.2020.
//

import UIKit
protocol DelegateArr{
    func update(_ data: [Post])
    
}
class PostTableViewController: UITableViewController, DelegateArr, UITextFieldDelegate{
    
    var saved:Bool = false
    
    @IBOutlet private weak var searchField: UITextField!
    @IBOutlet private weak var savedButton: UIBarButtonItem!
    @IBAction private func savedButtonClick(_ sender: Any) {
        UseCase.changeSaved()
        saved = !saved
        searchField.isHidden = !searchField.isHidden
        searchField.isEnabled =  !searchField.isEnabled
        
    }
    
    func reload(){
        DispatchQueue.main.async {
           
         self.tableView.reloadData()
           
            
        }
    }
    
    
    func update(_ data: [Post]){
        loadingData = false
        
        self.data = data
       
        reload()
        
    
    }
    var data: [Post] = []
    
   
    
    private var myViewModel:MyViewModel = MyViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchField.delegate = self
        self.hideKeyboardWhenTappedAround()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)()
        searchField.isHidden = !saved
        searchField.isEnabled =  saved
        if(data.count == 0){
            myViewModel.delegateArr = self
            myViewModel.update()
           
        }
       
    }
    
    func textField(_ textField: UITextField,
                    shouldChangeCharactersIn range: NSRange,
                    replacementString string: String) -> Bool{
       
        myViewModel.filter(searchField.text!)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myViewModel.filter(searchField.text!)
        
        searchField.endEditing(true)
            return true
        }
    
    // MARK: - Table view data source
    func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            myViewModel.filter(searchField.text!)
            
            searchField.endEditing(true)
        }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print("ASAasdasdasdasd")
        return data.count
    }
   
   
    var loadingData = false
    private var lastContentOffset: CGFloat = 0
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
            let contentHeight = scrollView.contentSize.height
        
            if contentHeight - scrollView.frame.height > 0{
                loadingData = true
               
            }
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as! PostTableViewCell
          
        if (loadingData && indexPath.row == data.count - 1) {
          
            myViewModel.update()
        }
//        if(indexPath.row == (data.count - 1 ) && self.data[indexPath.row].author != ""){
//            DispatchQueue.global().async {
//                self.myViewModel.update()
//            }
//
//            print("load more")
//        }
        cell.configure(for: self.data[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        switch segue.identifier {
        case "moveNext":
           
            if let indexPath = (sender as? IndexPath)?.row{
                let a = segue.destination as! ViewController
                
                a.updateFull(data[indexPath], pos:indexPath)
                }
        default:
            ()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //print("AAO")
        self.performSegue(withIdentifier: "moveNext", sender: indexPath)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    

}
