//
//  SQAutoScrollView.swift
//  SQAutoScrollView
//
//  Created by ysq on 2017/10/10.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit
import Kingfisher

class SQAutoScrollCell: UICollectionViewCell {
    
    public var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupImageView() {
        imageView = UIImageView()
        imageView?.frame = self.bounds
        imageView?.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
        contentView.addSubview(imageView!)
        
    }
    
}


public class SQAutoScrollView: UIView {

    public typealias didSelectedItem = (_ autoScrollView: SQAutoScrollView, _ itemIndex: Int) -> ()
    
    public var clickCompletionHandler: didSelectedItem!
    
    public var interval: TimeInterval = 3.0 {
        didSet {
            timerDestroyed()
            setupTimer()
        }
    }
    
    public var isAuto = true {
        didSet {
            timerDestroyed()
            if isAuto {
                setupTimer()
            }
        }
    }
    
    private var totalCount = 0
    
    public var imageUrls = [String]() {
        didSet {
            guard imageUrls.count > 0 else {
                print("image urls count is 0")
                return
            }
            checkImageUrlsIsIllegal()
            setTotalCount()
            pageControl?.numbersOfPages = imageUrls.count
            collectionView?.reloadData()
        }
    }
    
    public var currentPage: Int = 0 {
        didSet {
            pageControl?.currentPage = currentPage
            guard totalCount > 1 else {
                return
            }
            collectionView?.scrollToItem(at: IndexPath(row: totalCount / 2 + currentPage, section: 0), at: UICollectionViewScrollPosition(), animated: false)
        }
    }
    
    public var pageControlAlignmet: SQPageControlAlignment = .center{
        didSet {
            pageControl?.alignment = pageControlAlignmet
        }
    }
    
    public var pageControl: SQPageControl?

    private var timer: Timer?
    
    private var collectionView: UICollectionView?
    
    private let reuseID = "SQAutoScrollCellId"
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setSubviews()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        setSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience public init(frame: CGRect, urls: [String]) {
        self.init(frame: frame)
        guard urls.count > 0 else {
            print("image urls count is 0")
            return
        }
        self.imageUrls = urls
        checkImageUrlsIsIllegal()
        setTotalCount()
    }
    
    convenience public init(frame: CGRect, urls: [String], didItemCallBack: @escaping didSelectedItem) {
        self.init(frame: frame, urls: urls)
        clickCompletionHandler = didItemCallBack
    }
    
    private func setSubviews() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.size.width, height: frame.size.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.delegate = self
        collectionView?.dataSource = self;
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        addSubview(collectionView!)
        
        collectionView?.register(SQAutoScrollCell.self, forCellWithReuseIdentifier: reuseID)
        
        pageControl = SQPageControl(frame: CGRect(x: 0, y: bounds.size.height / 5 * 4, width: bounds.size.width, height: bounds.size.height / 5))
        pageControl?.currentPage = 0
        addSubview(pageControl!)
    }
        
    private func setupTimer() {
        guard isAuto && totalCount > 1 else {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(startAutoScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    @objc private func startAutoScroll() {
        var itemIndex = currentIndex() + 1
        var animated = true
        if itemIndex >= totalCount {
            itemIndex = itemIndex / 2
            animated = false
        }
        collectionView?.scrollToItem(at: IndexPath(row: itemIndex, section: 0), at: .left, animated: animated)
    }
    
    private func currentIndex() -> Int {
        return Int((collectionView?.contentOffset.x)! / bounds.size.width)
    }
    
    private func timerDestroyed() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func setTotalCount() {
        pageControl?.numbersOfPages = imageUrls.count
        if imageUrls.count <= 1 {
            isAuto = false
            totalCount = 1
            return
        }
        totalCount = imageUrls.count * 100
        currentPage = 0
        timerDestroyed()
        setupTimer()
    }
    
    private func checkImageUrlsIsIllegal() {
        for url in imageUrls {
            if !url.hasPrefix("http://") && !url.hasPrefix("https://") {
                print("image url format is error, please check it")
            }
        }
    }
    
    override public func removeFromSuperview() {
        super.removeFromSuperview()
        timerDestroyed()
    }
    
    deinit {
        timer = nil
    }

}

extension SQAutoScrollView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.size.width, height: bounds.size.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item % imageUrls.count
        clickCompletionHandler?(self, index)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as? SQAutoScrollCell
        let index = indexPath.item % imageUrls.count
        let url = imageUrls[index]
        cell?.imageView?.kf.setImage(with: URL(string: url))
        return cell!
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalCount
    }
    
}

extension SQAutoScrollView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = currentIndex()
        pageControl?.currentPage = index % imageUrls.count
        
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if isAuto {
            timerDestroyed()
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isAuto {
            setupTimer()
        }
    }
}

