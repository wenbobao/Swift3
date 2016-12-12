//
//  BookViewController.swift
//  LearnSwiftLanguage
//
//  Created by bob on 16/12/12.
//  Copyright © 2016年 bob. All rights reserved.
//

import UIKit
import Foundation

class BookViewController: UITableViewController {

    var dataSource = [Dictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "swift基础语法";

        let nib = UINib.init(nibName: "BookTitleCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "BookTitleCell")
        
        let file = Bundle.main.path(forResource: "data", ofType: "json")
        let url = URL(fileURLWithPath: file!)
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data)
        
        print(json)
        
        if let stationArray = json["station"].array {
            
            for stationJSON in stationArray {
                self.dataSource.append(stationJSON)
            }

        } else {
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTitleCell", for: indexPath) as! BookTitleCell
        cell.bookNameLabel.text = self.dataSource[indexPath.row]["name"] as? String

        return cell
    }

}

