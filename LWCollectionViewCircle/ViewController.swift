//
//  ViewController.swift
//  LWCollectionViewCircle
//
//  Created by 张星星 on 16/6/19.
//  Copyright © 2016年 LW. All rights reserved.
//

import UIKit

class Phone {
    var imageData : NSData
    
    init(imageData : NSData)
    {
      self.imageData = imageData
    }
}

class ViewController: UIViewController {
 
    lazy var itemArray : [Phone] = {
        var phones = [] as [Phone]
        for i in 0..<10
        {
            let image = UIImage(named:"\(i)_full")!
            let imageData = UIImageJPEGRepresentation(image, 1.0)!
            let photo = Phone(imageData : imageData)
            phones.append(photo)
        }
        return phones
    }()
    
   lazy var circleCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical  //滚动方向
        layout.minimumLineSpacing = 10.0  //上下间隔
        layout.minimumInteritemSpacing = 5.0 //左右间隔
    // 一定要这样创建的时候有 layout ，frame不可以为空或者在viewWillLayoutSubviews的时候赋值
       let circle = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
    circle.registerClass(LWCircleCollectionViewCell.self, forCellWithReuseIdentifier: "LWCircleCollectionViewCell")
    circle.backgroundColor = UIColor.clearColor()
       return circle
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let normalBtn = UIButton()
        normalBtn.frame = CGRectMake(0, 64, self.view.bounds.size.width / 2, 100)
        normalBtn.setTitle("正常布局", forState: .Normal)
        normalBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        normalBtn.addTarget(self, action: #selector(self.normalLayout), forControlEvents: .TouchUpInside)
        self.view .addSubview(normalBtn)
        let circleBtn = UIButton()
        circleBtn.frame = CGRectMake(self.view.bounds.size.width / 2, 64, self.view.bounds.size.width / 2, 100)
        circleBtn.setTitle("圆形布局", forState: .Normal)
        circleBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
         circleBtn.addTarget(self, action: #selector(self.circleLayout), forControlEvents: .TouchUpInside)
        self.view .addSubview(circleBtn)
        
        self.circleCollectionView.delegate = self;
        self.circleCollectionView.dataSource = self;
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(ViewController.longPressAction(_:)))
        self.circleCollectionView .addGestureRecognizer(longPress)
        view.addSubview(self.circleCollectionView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.circleCollectionView.frame = CGRectMake(0, 164, self.view.bounds.size.width, self.view.bounds.size.height - 164)
    }
    func normalLayout() {
        self.circleCollectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
    }
    
    func circleLayout() {
        self.circleCollectionView.setCollectionViewLayout(LWCircleLayout(), animated: true)
    }
    
    func longPressAction(gusture : UILongPressGestureRecognizer){
        
        let indexPath = self.circleCollectionView.indexPathForItemAtPoint(gusture.locationInView(self.circleCollectionView))
        
        switch gusture.state {
        case .Began:
            self.circleCollectionView.beginInteractiveMovementForItemAtIndexPath(indexPath!)
        case .Changed:
            self.circleCollectionView.updateInteractiveMovementTargetPosition(gusture.locationInView(self.circleCollectionView))
        case .Ended:
            self.circleCollectionView.endInteractiveMovement()
        default: break
            
        }
        
        
    }
    
    
}
/// 要实现前两个协议，不然会报错
extension ViewController : UICollectionViewDataSource ,UICollectionViewDelegate
{


    //设置分区个数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //设置每个分区元素个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.itemArray.count
    }
    // 设置每个元素的尺寸
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
         return CGSizeMake(60, 60)
    }

    //设置元素内容
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell  {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LWCircleCollectionViewCell", forIndexPath: indexPath) as! LWCircleCollectionViewCell
    cell.imageView.image = UIImage(data:self.itemArray[indexPath.item].imageData)
    cell.layer.cornerRadius = cell.frame.size.height * 0.5
    cell.layer.masksToBounds = true
    cell.layer.borderColor = UIColor.redColor().CGColor
    cell.layer.borderWidth = 1.0
        return cell
    }
    // 选中某个item
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.item)")
    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let selectIndex = sourceIndexPath.item
        let destIndex = destinationIndexPath.item
        let item = self.itemArray.removeAtIndex(selectIndex)
        itemArray.insert(item, atIndex: destIndex)
    }
    
}
