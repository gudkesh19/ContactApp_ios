# ContactApp

## Version

1.0

## Build and Runtime Requirements
+ Xcode 10.0 or later
+ iOS 11.0 or later


## Configuring the Project

Configuring the Xcode project requires a few steps in Xcode to get up and running the app.  

1) Configure  iOS device you plan to test . Create or use an existing Apple ID account .

2) Configure the Team  target within the project to run the app on device.

Open the project in the Project navigator within Xcode and select the target. Set the Team on the General tab to the team associated with your developer account.

3) Change the Bundle Identifier.

With the project's General tab still open, update the Bundle Identifier value. The project's ContactApp target ships with the value:

com.Exilant.ContactsApp

You should modify the reverse DNS portion to match the format that you use:



## About ContactApp

ContactsApp is an iOS utility app. In this app, the user can create new contacts, view contact details and can import contacts.

## Written in Objective-C and Swift

This app is written using both Objective-C and Swift. 




## Application Flow


The iOS version of ContactsApp follows many of the  design principles like  the Model-View-Controller (MVC), MVP, design pattern and uses modern app development practices including Storyboards and Auto Layout. In the iOS version of ContactsApp, the user manages contact lists using a table view implemented in the ContactListViewController class written in objective - C.

A user can store their contacts locally. Coredata has been used to store the contacts locally on device.

Once the contact list of  is visible, a user can tap on a list to show the contact details(ContactDetailsViewController). This class displays  a single contact. If a user wants to create a new contact, he can tap on the "+" to display an instance of the NewContactViewController. 




## Swift Features

The ContactsApp sample leverages many features unique to Swift, including the following:

###### Codable

###### String Constants

###### Extensions on Types at Different Layers of a Project



