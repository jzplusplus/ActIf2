# ActIf 2

Allows you to use conditionals with Activator
Available on the BigBoss repo in Cydia

# Detailed Explanation
Normally with Activator, you set up listeners and actions. Listeners are triggered by a certain user action or event, like triple-clicking the home button or opening an app. Actions cause something to happen, like opening up Siri or changing your music to the next track. Each listener can be connected to an action so that you can tell your device what to do. E.g. "when I press both volume buttons, turn the flashlight on".

The normal path for an Activator event is "listener -> action".

ActIf adds conditionals to the mix. These conditionals check something about the current state of your device, such as whether or not you are connected to wifi. Then they allow you to have different actions if they pass or fail. E.g. "when I press the volume up button, _if music is currently playing_ change the next track".

Conditionals act as a branching path for Activator events. Instead of "listener -> action", you now have "listener -> conditional" plus "conditional passed -> action" and "conditional failed -> action".

# Example config
Let's say you want "triple-click home button" to open up a music app. When you're on wifi you want it to open Spotify, but when you're not on wifi you want it to open the Music app
1. Open ActIf 2 app
2. Tap +, tap the empty condition box, tap WifiConnectedCondtition
3. Tap Back and ActIf to get to the main screen, then tap Respring (now the condition is ready to be connected in Activator)
4. Go to Setttings, scroll down and tap Activator
5. Tap Anywhere, then find Triple Press in the Home button section
6. Tap "Check if Wifi Connected" under the ActIf conditions section (now the "listener -> condition" is connected)
7. Tap the back button to return to the Anywhere screen
8. Tap "Wifi Connected" under the ActIf Results section
9. Tap Spotify under User Applications (now one branch is set up for "conditional passed -> action")
10. Tap the back button to return to the Anywhere screen
11. Tap "Wifi Not Connected" under the ActIf Results section
12. Tap Music under System Applications (now the other branch is set up for "conditional failed -> action")
Done!
