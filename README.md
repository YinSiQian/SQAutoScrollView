# SQAutoScrollView
An auto scroll banner framework that is simple and easy to use


# install
pod 'SQAutoScrollView', '~>1.0.1'

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
//auto scroll interval
cycleView.interval = 1
//currentPage default is 0, it must be set after property imageUrls, otherwise no works.
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

# hope
if you found some bug when used, hope you can issue me.  Thanks.</br>
if you hope have new function, hope you can issue me, i'd love to add more useful function to this framework. Thanks.

