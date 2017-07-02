//
//  ChatViewController.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 07/06/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var chatTableView: UITableView!
	
	let circleRetriever: CircleRetriever = CircleRetriever()
	let pointRetriever: PointRetriever = PointRetriever()
	
	var user: User
	var points: [Point]
	
	init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, user: User) {
		self.user = user;
		self.points = []
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
		
		self.chatTableView.delegate = self
		self.chatTableView.dataSource = self
		self.chatTableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "chatCell")
		self.chatTableView.estimatedRowHeight = 90.0
		self.chatTableView.rowHeight = UITableViewAutomaticDimension
		
		getAllPoints()
		
		self.chatTableView.reloadData()
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
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: ChatCell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
		
		let point: Point = self.points[indexPath.row]
		
		cell.labelMessage.text = point.content
		cell.labelDetails.text = "par \(point.user.firstname!) \(point.user.lastname!) le \(point.created)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.points.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	}
	
	func getAllPoints() {
		// Request to retrieve messages from API
		circleRetriever.getCircle(idUser: self.user.id!) { (circle) in
			if(circle != nil) {
				self.pointRetriever.getPoints(idLine: (circle?.lines?[0].id)!, callback: { (points) in
					self.points = []
					self.points.append(contentsOf: points)
					
					DispatchQueue.main.async(execute: {
						self.chatTableView.reloadData()
						self.scrollToBottom()
					})
				})
			}
		}
	}
	
	@IBAction func sendPoint(_ sender: UIButton) {
		
	}

	func scrollToBottom() {
		if(self.points.count > 0) {
			let lastRowIndexPath = IndexPath(item: self.points.count - 1, section: 0)
			self.chatTableView.scrollToRow(at: lastRowIndexPath, at: UITableViewScrollPosition.bottom, animated: true)
		}
	}
}
