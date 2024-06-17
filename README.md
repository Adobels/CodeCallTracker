# FunctionCallTracker

FunctionCallTracker facilitates executing code exclusively on the first call of a function


example: 

```swift
class ViewController: UIViewController {

    var funcTracker = FunctionCallTracker()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated: animated)
            if funcTracker.isFirstTimeCall() {
                // do something only on first call of viewWillAppear
            } else {
                // do something on other calls of viewWillAppear
            }
    }
}
```
