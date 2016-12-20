//
//  BookViewController.swift
//  LearnSwiftLanguage
//
//  Created by bob on 16/12/12.
//  Copyright © 2016年 bob. All rights reserved.
//

import UIKit
import Foundation
import SafariServices

class BookViewController: UITableViewController {

    var dataSource: [[String : AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "swift基础语法";

        let file = Bundle.main.path(forResource: "data", ofType: "json") // Optional String
        let url = URL(fileURLWithPath: file!) //拆包
        
        // 一
//        do {
//            let data = try Data(contentsOf: url)
//            let allBooks = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
//            if let arrJSON = allBooks["swift"] {
//                dataSource = arrJSON as! [[String : AnyObject]]
//            }
//        }
//        catch {
//            
//        }
        
        // 二
        
        let data = try? Data(contentsOf: url) //Optional Data
        let allBooks = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : AnyObject] ////Optional [String : AnyObject]
        
        if let arrJSON = allBooks?["swift"] {
            dataSource = arrJSON as! [[String : AnyObject]]
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let bookurl = self.dataSource[indexPath.row]["url"] as! String
        
        present(SFSafariViewController.init(url: URL.init(string: bookurl)!), animated: true, completion: nil)
    }

}

