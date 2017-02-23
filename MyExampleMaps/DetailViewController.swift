//
//  DetailSessionViewController.swift
//  MyExampleMaps
//
//  Created by Kirill on 16.02.17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
   // @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    var indexPathRow: Int = 0
    var _session = SessionData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _session.saveContext()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as!
        CustomDataSessionTableViewCell
          var session =  _session.arraySession(index: indexPathRow)
      print(session)
        switch indexPath.row {
        case 0:
            cell.nameLable.text = "Adress:"
            cell.valueLable.text! = session[indexPath.row]
        case 1:
            cell.nameLable.text = "Lat:"
            cell.valueLable.text = String(session[indexPath.row])
        case 2:
            cell.nameLable.text = "Long:"
            cell.valueLable.text = String(session[indexPath.row])
        case 3:
            cell.nameLable.text = "Wheather:"
            cell.valueLable.text = session[indexPath.row]
        default:
            cell.nameLable.text = ""
            cell.valueLable.text = ""
        }

        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
}
