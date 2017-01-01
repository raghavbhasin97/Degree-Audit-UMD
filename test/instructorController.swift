//
//  instructorController.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/15/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit


class instructorController: UIViewController , UIViewControllerTransitioningDelegate, UITableViewDelegate, UITableViewDataSource{
    
    let transition = slideTransition(style: .slideRight)
  
    
    @IBOutlet weak var navigationBar: UINavigationBar!
 

    override func viewDidLoad() {
        
        super.viewDidLoad()
     
        dataSet.sortInstructor()

        navigationBar.titleTextAttributes
            = [NSForegroundColorAttributeName: UIColor(netHex: 0xD76197),
               NSFontAttributeName: UIFont(name: "ChalkboardSE-Bold", size: 19.0)!]

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        for Views in self.view.subviews {
            Views.removeFromSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let toViewController = segue.destination as UIViewController
        
        toViewController.modalPresentationStyle = .custom
        toViewController.transitioningDelegate = self.transition
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        if(indexPath.row == 0) {
            let identifier = "instructorCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! InstructorTableViewCell
            cell.title.font = UIFont.boldSystemFont(ofSize: 16)
            cell.Leafimage.image = UIImage(named: "fall")
            cell.title.text = "FALL"
            cell.title.textColor = UIColor(netHex: 0xF5512E)
             return cell
        } else {
            
            let identifier = "instructorCell2"
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! InstrictorSTableViewCell
            cell.title.font = UIFont.boldSystemFont(ofSize: 16)
            cell.leafImage.image = UIImage(named: "spring")
            cell.title.text = "SPRING"

             cell.title.textColor = UIColor(netHex: 0x5B0064)
             return cell
        }
        
        
       
    }
    
}
