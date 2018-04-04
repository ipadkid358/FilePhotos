## FilePhotos

Attempt at choosing any file (from filesystem) from the native iOS image picker.

This tweak works by creating pseudo classes of relevant classes in the Photo stack. The goal is to be able to provide stubbed out information, in order for the app to eventually get correct NSData. This will obviously not work for some instances, such as displaying an image, however, is good for messaging apps that just send the data to the server.
