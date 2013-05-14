GlassMapRelayTechnology
====================

Glassmap (recently acquired by Groupon) implemented what they call "Relay Technology" in order to reduce battery drain while running in the background on iOS. When the company launched they claimed to reduce battery drain from background location updates by an order of magnitude from 5%/hour to .5%/hour ([source](http://techcrunch.com/2012/02/16/yc-backed-glassmap-launches-a-find-my-friends-for-facebook-users-on-iphone-android/)). When I found out about Glassmap I did a bit of research, found the solution, and wrote a [blog post](http://bthdonohue.tumblr.com/post/48148116224/glassmap-relay-technology) about my findings. The blog post continues to get interest and hits (mostly through [Quora](http://www.quora.com/How-does-Glassmaps-battery-saving-passive-location-technology-relay-work)), and the real missing piece was the proof of concept. This project is meant to serve as a proof of concept for how the Glassmap Relay Technology works on iOS.

Proof of Concept
-----------------

The proof of concept is extremely simple, but it requires that the application implement both background location updates and VOIP capabilities for iOS. The UIApplication [setKeepAliveTimeout:handler:](http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIApplication_Class/Reference/Reference.html#//apple_ref/occ/instm/UIApplication/setKeepAliveTimeout:handler:) function available with VOIP allows the application to have another background hook which can then allow a developer to turn background location updates on and off as necessary.

The proof of concept is comprised of roughly 40 lines of code, and simply turns the background location updates on/off every 10 minutes:

* Register for location updates in background
* Register for VOIP keep alive handler
* Switch background location updates on/off every 10 minutes (smallest allowed keep alive timeout)

Sample Output
----------------
2013-05-13 23:14:30.280 GlassmapRelayTechnology[51779:c07] Keep alive handler registered

2013-05-13 23:14:30.287 GlassmapRelayTechnology[51779:c07] Did update to location: 40.747214, -74.004722

2013-05-13 23:14:30.943 GlassmapRelayTechnology[51779:c07] Did update to location: 40.747214, -74.004722

.......

2013-05-13 23:24:30.025 GlassmapRelayTechnology[51779:c07] Did update to location: 40.747214, -74.004722

2013-05-13 23:24:30.274 GlassmapRelayTechnology[51779:c07] Keep alive: Stopping location updates

2013-05-13 23:34:30.269 GlassmapRelayTechnology[51779:c07] Keep alive: Starting location updates

2013-05-13 23:34:30.275 GlassmapRelayTechnology[51779:c07] Did update to location: 40.747214, -74.004722

Implications
-----------------

Developer control of background location updates can significantly improve battery life for iOS applications by turning the updates off when the developer sees fit. For instance, if a user has been stationary for a few hours it is probably safe to assume they are at work or home and the background location updates can be turned off to save battery life. None of that logic is implemented in this proof of concept, but essentially that is how Glassmap was able to achieve the battery savings while the application was running in the background.

