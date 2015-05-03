//
//  ViewController.swift
//  SwiftGame
//
//  Created by Jose Zamudio on 5/3/15.
//  Copyright (c) 2015 zamudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var total = 0

	var topView:UIView = UIView()
	var middleView:UIView = UIView()
	var bottomView:UIView = UIView()
	
	var selectedNumbers:NSMutableArray = NSMutableArray()
	var getRandomButton:UIButton = UIButton()
	var label:UILabel = UILabel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.purpleColor()
		drawTopView()
		drawMiddleView()
		drawBottomView()
	}
	
	func drawTopView() {
		self.topView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height * 0.25))
		
		var screenView:UIView = UIView(frame: CGRectMake(15, 25, self.view.frame.width - 30, self.topView.frame.height - 50))
		screenView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
		
		self.label = UILabel(frame: CGRectMake(0, 0, screenView.frame.width, screenView.frame.height))
		self.label.textAlignment = NSTextAlignment.Center
		self.label.text = "0"
		
		screenView.addSubview(self.label)
		
		self.topView.addSubview(screenView)
		
		self.view.addSubview(self.topView)
	}
	
	func drawMiddleView() {
		self.middleView = UIView(frame: CGRectMake(0, self.topView.frame.height, self.view.frame.width, self.view.frame.height * 0.50))
		drawGrid()
		self.view.addSubview(self.middleView)
	}
	
	func drawBottomView() {
		self.bottomView = UIView(frame: CGRectMake(0, self.topView.frame.height + self.middleView.frame.height, self.view.frame.width, self.view.frame.height * 0.25))
		
		self.getRandomButton = UIButton(frame: CGRectMake(15, 25, self.view.frame.width - 30, self.bottomView.frame.height - 50))
		self.getRandomButton.backgroundColor = UIColor.redColor()
		self.getRandomButton.setTitle("Get a random number!", forState: .Normal)
		self.getRandomButton.addTarget(self, action: "getRandomNumber", forControlEvents: .TouchUpInside)
		
		self.bottomView.addSubview(self.getRandomButton)
		self.view.addSubview(self.bottomView)
	}
	
	func drawGrid() {
		var height = self.middleView.frame.height / 3
		var width = self.middleView.frame.width / 3
		var count = 1
		for i in 0...2 {
			for j in 0...2 {
				var subview:UIView = UIView(frame: CGRectMake(width * CGFloat(j), height * CGFloat(i), width, height))
				var button:UIButton = UIButton(frame: CGRectMake(15, subview.frame.height * 0.10, subview.frame.width - 30, subview.frame.height * 0.8))
				button.tag = count
				button.backgroundColor = UIColor.redColor()
				button.setTitle("\(count)", forState: UIControlState.Normal)
				button.addTarget(self, action: "clickEvent:", forControlEvents: .TouchUpInside)
				count++
				subview.addSubview(button)
				self.middleView.addSubview(subview)
			}
		}
	}
	
	func clickEvent(sender: AnyObject) {
		if (self.total > 0) {
			var button:UIButton = sender as! UIButton
			self.selectedNumbers.insertObject(button.tag, atIndex: 0)
			var sum = 0
			for number in self.selectedNumbers {
				sum += number as! Int
			}
			self.label.text = "\(sum)"
			if (sum == self.total) {
				var alert:UIAlertView = UIAlertView(title: "YOU WON!", message: "You got the right number!", delegate: self, cancelButtonTitle: "Ok")
				alert.show()
				reset()
			} else if (sum > self.total) {
				var alert:UIAlertView = UIAlertView(title: "YOU LOST!", message: "Learn how to add!", delegate: self, cancelButtonTitle: ":(")
				alert.show()
				reset()
			}
		}
	}
	
	func getRandomNumber() {
		self.label.text = "0"
		self.total = Int(arc4random_uniform(45) + 1)
		self.getRandomButton.setTitle("\(self.total)", forState: .Normal)
	}
	
	func reset() {
		self.total = 0
		self.label.text = "0"
		self.getRandomButton.setTitle("Get Random Number", forState: .Normal)
		self.selectedNumbers.removeAllObjects()
	}
	
}
