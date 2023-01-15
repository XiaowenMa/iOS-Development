# iOS_Development
This folder contains the projects (except for the final project) of CSE 438S Introduction to Mobile App Development(iOS). All the projects were individual projects developed in Swift.

# Lab1 - Shopping Caculator

In this app, I add the following addtional features:

I add several different currency for users to  choose(USD RMB and EURO), the default currency is USD, and user can view the price in a different currency by clicking the corresponding button and the app will show the price as well as the exchange rate.

I think this functionality would be useful for the travelers who may want to transform the US dollars into their familiar currency(which they earn in their home country), thus they can get a sense of how much the goods cost (maybe they can compare the price of the good in US and the one in their home country) and then determine how many they want to buy.

# Lab2 - Virtual Pet App
This app is a virtual pet app, in which you can switch between, feed, play with a variety of pets. The users need to take care of the pets and increase their health and happiness level.

For the additional features, I add a Segmented Control at the bottom of the pet image, which lists all the pets a user have. Given the current pet(which is shown on the image), the user can choose from the segment bar to see whether the selected pet is a friend of the current chosen one. Given different combination, the status of related pets will be updated.

I add this feature since I think it would be fun to let the user to test and figure out the relationship between different pets, and besides playing the pets by ourselves, we can also let some of them play together.
The user will need to choose from the segmented control, the default choice is. “friend?’, and different choice will lead to a different result, and the related data would then be changed accordingly.

# Lab3 - Drawing App
This app is a drawing app, in which users can do free drawings and regular shapes, such as circle, dots. They can also customize their color palette.

For the creative part, I include the following features into my drawing app:
For the creative part, I include the following features into my drawing app: A custom color palette along with three sliders to change the RGB values, respectively. As the user moves the slider, the updated color will show up in that custom button. Different choices of line type: including straight line, free curve, and dashed line. The user can choose from the three buttons, and draw with a particular line type. The users can choose their preferred line types from straight line, free curves, and dashed lines. The default type is free curve. There is also a slider at the top right to change the opacity of the drawing. As the user moves the slider, the colors in the palate will be updated as well.
 
I create a customButton subclass, and each custom button has a color attribute(UIColor), and the current Path will be drawn in the chosen color. The user can use the 3 RGB sliders to modify the color. The user can switch between dashed/solid lines by clicking on the "line-type" button. The user can also change the transparency of the pens through another opacity slider.  The featrues will help create different types of marks and make more complex drawings.

# Lab4 - Movie Search App
This app is a movie search app using TMDB database. The user can log in to their account, search the movies and add them to "favorite" album.

In this app, I implement the following additional features:

I add the register/login(email-password) functionality to the app using firebase. The user can also reset there password through a reset link sent to the registered email address, and there can be multiple user account on the same device, each user will have separate space to save their favorite movies and comments. ***You can log in the app using test1@email.com password:123456. The users can add/update comments to the movies by clicking on the tableview cell in his/her favorite movie list.

The third point is a combination of some small features:

i)                    The user can choose the search language through a UIPickerView

ii)                   After logging in, I will load the most popular movies to them as default ones

iii)                 I want to allow the user to save the poster of movies into the photo library.

I add the login functionality because of user privacy. Users may want to keep their data privately and not seen by other people by simply clicking upon the app icon. I add the “add notes” functionality to favorite movies for users' to document their thoughts. The users can also choose their preferred languages and download the posters they like. 

I embed another navigation controller and a few more custom viewcontroller for the homepage, sign up and login screen and use firebase’s api(especially the authentication part) to implement user login/register and password reset.
To differentiate users’ favorite movies and comments data, I add a new plist to save all users’ username on the current device. 
and use different viewControlelr for user to update their comments for a movie.
Additionally, I use UIPickerView to allow user choosing different languages and use UIImageWriteToSavedPhotosAlbum() method to allow user save pictures into photo album.
