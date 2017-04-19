//
//  ViewController.swift
//  LWCollectionViewCircle
//
//  Created by 张星星 on 16/6/19.
//  Copyright © 2016年 LW. All rights reserved.
//

import UIKit

class Phone {
    var imageData : Data
    
    init(imageData : Data)
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
        layout.scrollDirection = UICollectionViewScrollDirection.vertical  //滚动方向
        layout.minimumLineSpacing = 10.0  //上下间隔
        layout.minimumInteritemSpacing = 5.0 //左右间隔
    // 一定要这样创建的时候有 layout ，frame不可以为空或者在viewWillLayoutSubviews的时候赋值
       let circle = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    circle.register(LWCircleCollectionViewCell.self, forCellWithReuseIdentifier: "LWCircleCollectionViewCell")
    circle.backgroundColor = UIColor.clear
       return circle
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let normalBtn = UIButton()
        normalBtn.frame = CGRect(x: 0, y: 64, width: self.view.bounds.size.width / 2, height: 100)
        normalBtn.setTitle("正常布局", for: UIControlState())
        normalBtn.setTitleColor(UIColor.blue, for: UIControlState())
        normalBtn.addTarget(self, action: #selector(self.normalLayout), for: .touchUpInside)
        self.view .addSubview(normalBtn)
        let circleBtn = UIButton()
        circleBtn.frame = CGRect(x: self.view.bounds.size.width / 2, y: 64, width: self.view.bounds.size.width / 2, height: 100)
        circleBtn.setTitle("圆形布局", for: UIControlState())
        circleBtn.setTitleColor(UIColor.blue, for: UIControlState())
         circleBtn.addTarget(self, action: #selector(self.circleLayout), for: .touchUpInside)
        self.view .addSubview(circleBtn)
        
        self.circleCollectionView.delegate = self;
        self.circleCollectionView.dataSource = self;
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(ViewController.longPressAction(_:)))
        self.circleCollectionView .addGestureRecognizer(longPress)
        view.addSubview(self.circleCollectionView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.circleCollectionView.frame = CGRect(x: 0, y: 164, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 164)
    }
    func normalLayout() {
        self.circleCollectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
    }
    
    func circleLayout() {
        self.circleCollectionView.setCollectionViewLayout(LWCircleLayout(), animated: true)
    }
    
    func longPressAction(_ gusture : UILongPressGestureRecognizer){
        
        let indexPath = self.circleCollectionView.indexPathForItem(at: gusture.location(in: self.circleCollectionView))
        
        switch gusture.state {
        case .began:
            self.circleCollectionView.beginInteractiveMovementForItem(at: indexPath!)
        case .changed:
            self.circleCollectionView.updateInteractiveMovementTargetPosition(gusture.location(in: self.circleCollectionView))
        case .ended:
            self.circleCollectionView.endInteractiveMovement()
        default: break
            
        }
        
        
    }
    
    
}
/// 要实现前两个协议，不然会报错
extension ViewController : UICollectionViewDataSource ,UICollectionViewDelegate
{


    //设置分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //设置每个分区元素个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.itemArray.count
    }
    // 设置每个元素的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
         return CGSize(width: 60, height: 60)
    }

    //设置元素内容
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LWCircleCollectionViewCell", for: indexPath) as! LWCircleCollectionViewCell
    cell.imageView.image = UIImage(data:self.itemArray[indexPath.item].imageData)
    cell.layer.cornerRadius = cell.frame.size.height * 0.5
    cell.layer.masksToBounds = true
    cell.layer.borderColor = UIColor.red.cgColor
    cell.layer.borderWidth = 1.0
        return cell
    }
    // 选中某个item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let selectIndex = sourceIndexPath.item
        let destIndex = destinationIndexPath.item
        let item = self.itemArray.remove(at: selectIndex)
        itemArray.insert(item, at: destIndex)
    }
    
}
