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
	
	var friend: User
	var points: [Point]
	var circle: Circle?
	
	init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, user: User) {
		self.friend = user;
		self.points = []
		self.circle = nil
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
		
		// Register socketIO receiver method
		SocketIOManager.sharedInstance.socket.on("new-private-point", callback: { (data, socketAckEmitter) in
			if(!(data[0] is String && (data[0] as! String) == SocketAckStatus.noAck.rawValue)) {
				
				let pointObj = data[0] as! Dictionary<String, AnyObject>
				let newPoint: Point = Point(object: pointObj)
				
				// If the new point belongs to this conversation, display it
				if(newPoint.idLine == self.circle?.lines?[0].id) {
					self.points.append(newPoint)
					self.chatTableView.reloadData()
					self.scrollToBottom()
				} else {
					// Otherwise, display a notification of new point in another line
					
				}
			}
		})
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
		cell.labelDetails.text = "par \(point.user!.firstname) \(point.user!.lastname) le \(point.created)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.points.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	}
	
	func getAllPoints() {
		let idUser: Int = StorageManager.getUser().id
		
		// Request to retrieve messages from API
		circleRetriever.getCircle(idUser: idUser, idFriend: self.friend.id, callback: { (circle) in
			if(circle != nil) {
				self.circle = circle!
				
				self.pointRetriever.getPoints(idLine: (circle?.lines?[0].id)!, callback: { (points) in
					self.points = []
					self.points.append(contentsOf: points)
					
					DispatchQueue.main.async(execute: {
						self.chatTableView.reloadData()
						self.scrollToBottom()
					})
				})
			}
		})
	}
	
	@IBAction func sendPoint(_ sender: UIButton) {
		
		let text: String = self.textView.text.trimmingCharacters(in: CharacterSet.whitespaces)
		self.textView.text = ""
		
		if(text.characters.count > 0) {
			let idLine: Int = (self.circle!.lines?[0].id)!
			let idUser: Int = StorageManager.getUser().id
			let date: Date = Date()
			
			pointRetriever.savePoint(text: text, idLine: idLine, idUser: idUser, created: date, callback: { (point) in
				if(point != nil) {
					SocketIOManager.sharedInstance.newPrivatePoint(point: point!, idFriend: self.friend.id)
				}
			})
		}
	}

	func scrollToBottom() {
		if(self.points.count > 0) {
			let lastRowIndexPath = IndexPath(item: self.points.count - 1, section: 0)
			self.chatTableView.scrollToRow(at: lastRowIndexPath, at: UITableViewScrollPosition.bottom, animated: true)
		}
	}
}
