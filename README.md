# CodeCallTracker

CodeCallTracker facilitates executing code exclusively on its first call 


example: 

```swift
class ViewController: UIViewController {

    private let code = CodeCallTracker()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated: animated)
        if code.isFirstTimeCall() {
            // do something only on first call of viewWillAppear
        } else {
            // do something on other calls of viewWillAppear
        }
    }
    
    override func updateViewConstraints() {
        if code.isFirstTimeCall() {
            // do something only on first call of updateViewConstraints
        } else {
            // do something on other calls of updateViewConstraints
        }
        super.updateViewConstraints()
    }
}
```
