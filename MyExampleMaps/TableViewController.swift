//
//  TableViewController.swift
//  MyExampleMaps
//
//  Created by Kirill on 15.02.17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    var sessionData = SessionData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    var sessions : [DataTime] = []
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        secondViewController.indexPathRow = row
       // self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! CustomTableViewCell
        sessionData.saveContext()
        let session = sessions[indexPath.row]
        cell.dataTime.text = session.dataTime!
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        print(indexPath.row)
        //Social
        let shareAction = UITableViewRowAction(style: .default, title: "Share", handler: { (actin, indexPath) -> Void in
            let sessionValue = self.sessionData.arraySession(index: indexPath.row)
            let defaultText = "Address: \(sessionValue[0]). Exact location: \(sessionValue[1]),\(sessionValue[2]). \(sessionValue[3])"
            print(defaultText)
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        })
    
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        return [shareAction]
    
    }
    

    func getData() {
        sessionData.saveContext()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            sessions = try context.fetch(DataTime.fetchRequest())
        }
        catch{
            print("Fenching failed")
        }
}
    

}
