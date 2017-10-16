# SQAutoScrollView
iOS Swift版本的图片轮播库,简单易用

# install
支持pod 安装</br>
pod 'SQAutoScrollView', '~>1.0.0'

# usage
```swift
let urls = ["image url", "image url"]
        
let cycleView = SQAutoScrollView(frame: CGRect.init(x: 0, y: 100, width: view.bounds.size.width, height: 300), urls: urls, didItemCallBack: { (view, index) in
            print("view--->\(view), index-->\(index)")
        })

view.addSubview(cycleView)
```

## customize 
```swift
let cycleView = SQAutoScrollView(frame: CGRect.init(x: 0, y: 100, width: view.bounds.size.width, height: 300), urls: urls, didItemCallBack: { (view, index) in
            print("view--->\(view), index-->\(index)")
        })
//轮播间隔时间
cycleView.interval = 1
//currentPage 属性需要在imageUrls设置完才能使用,否则无效.默认为0
cycleView.currentPage = 1   
cycleView.pageControl?.alignment = .right
cycleView.pageControl?.style = .rectangle
cycleView.pageControl?.currentPageIndicatorTintColor = UIColor.blue
cycleView.pageControl?.pageIndicatorTintColor = UIColor.red
view.addSubview(cycleView)
```
# requirements
Xcode 9</br>
iOS 8.0+</br>
Swift 4.0</br>
Dependency Kingfisher 4.0.1

# issue
如果发现有错误,请及时告诉我,email ysq405515@sina.com,我会及时修复这个问题.谢谢大家.
