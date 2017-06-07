//
//  ChatViewController.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 07/06/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var sendBtn: UIButton!
	
	var user: User;
	
	init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, user: User) {
		self.user = user;
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.textView.layer.borderWidth = 5.0
		self.textView.layer.borderColor = UIColor.blue.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
