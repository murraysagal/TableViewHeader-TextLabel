# TableViewHeader-TextLabel
Shows how to access a UITableViewHeaderFooterView and its textLabel attribute and what can go wrong. The problems demonstrated in this app are as of iOS 12.1.4, Xcode 10.1, and Swift 4.2. 

### Description
It's easy to access a header view from a table view and to dynamically change the text. Here's a snippet: 

    guard let headerView = tableView.headerView(forSection: section), let label = headerView.textLabel else {return}
    label.text = "Here's a new header title"

Here's the link to the docs for UITableViewHeaderFooterView's textLabel attribute: https://developer.apple.com/documentation/uikit/uitableviewheaderfooterview/1624912-textlabel

This is my favorite part: 

> The label is sized to fit the content view area in the best way possible based on the size of the string. Its size is also adjusted depending on whether there is a detail text label present.

As this app demonstrates this appears to be true only if you change the label text and then immediately reload the table view with one of the reload functions. But it is not always desirable to reload (maybe you'll lose the selection or there's a text field being edited in one of the cells). 

If you want to see the issues first-hand clone this repo and run on your device or simulator. 

### Demo

Run the app and you'll see a table view with a header and footer. 

- tap the `a` row

There are two obvious problems...

1. The text is truncated. It appears to be truncated at exactly the length of the default header.
1. The text is lowercase.
1. The other problem is that the header title for `a` is actually two lines. All the others are single line.

- swipe up to force the header to reload. That's how it should look.

- tap the `b` row

This works because the title is shorter than the one before. But notice that it's sitting really high. 

- tap the `c` row

Notice that it is wrapping to a new line but that's because the previous one was two lines. 

- swipe up to force the header to reload. 

Now we have what is expected. 

There are many questions about this on stackoverflow. A common answer is to use `sizeToFit()`. So let's try that. 

In `updateHeaderTitle(...)` uncomment the `sizeToFit()` line and run again.

- tap on the `a` row

That's worse. Again, it seems like the label's width is stuck to the original. 

- tap the `b` row

That's bad. The header title for the `b` row is just the letter `b`. 

- tap the `a` row again. 

That's pretty messed up. It looks like it's trying to fit the label into the width of the last header title. 

- Swipe up to force the header to reload. That fixes it. 

### Workaround
One workaround that might work in most cases is to set the label's `numberOfLines` attribute. Uncomment the `numberOfLines` line and run again.
