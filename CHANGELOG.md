## 3.0.0

* **Breaking:** make `TWCalendarController.state` private; use `updateData()` to refresh the calendar
* detach disposed or replaced controllers and clear stale non-consecutive selections when replacing a controller
* fix calendar overflow in narrow containers and Web bottom sheets by sizing date cells to the available width
* keep custom date widgets sized correctly when the calendar is resized
* fix long today labels overflowing narrow date cells
* fix oversized text and layouts in the Web example by removing screen-wide scaling
* add regression tests for desktop and mobile layouts, resizing, and custom date selection
* add unit tests for calendar utilities and controller lifecycle behavior
* restore the Android example with v2 embedding and update the iOS example for current Xcode versions
* add GitHub Actions for formatting, analysis, native and Chrome tests, and Android and iOS example builds

## 2.0.0

* support limit max and min selected days
* rename file

## 1.2.1

*  support month position offset

## 1.2.0

* support custom date widget

## 1.1.0

* support not serial multiple selection
* fix bug

## 1.0.2

* add export class

## 1.0.1

* remove unnecessary dependencies libraries

## 1.0.0

* support change to modify style configures

## 0.1.3

* fix bug

## 0.1.2

* support control ensure button title
* support modify day color

## 0.1.1

* support continuous selection
* support custom headerView 
* support modify widgets height
* fix bug

## 0.1.0

* simple calendar
* Initial release
