General architecture is inspired by MVVM-C where C is for Coordinator.
Main idea is to move all navigation-related actions from views and view models to dedicated objects.

Loading is inspired by objc.io talk. This approach is easilly extendable and pretty simple.

As demo data is generated for GMT+1 there is a workaround with NSTimeZone.default.

In real life we should add caching for images. 
