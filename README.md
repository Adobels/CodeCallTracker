# CodeCallTracker

CodeCallTracker facilitates executing code exclusively on its first call 


example: 

```swift
class ViewController: UIViewController {

    private let codeTracker = CodeCallTracker()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated: animated)
        if codeTracker.isFirstTimeCall() {
            // do something only on first call of viewWillAppear
        } else {
            // do something on other calls of viewWillAppear
        }
    }
    
    override func updateViewConstraints() {
        if codeTracker.isFirstTimeCall() {
            // do something only on first call of updateViewConstraints
        } else {
            // do something on other calls of updateViewConstraints
        }
        super.updateViewConstraints()
    }
}
```
