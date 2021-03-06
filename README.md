## Mulka: A Property Investment Platform

[Mulka](https://mulka.herokuapp.com/) is a platform that enable investors to own units of a property by acquiring units they can afford. This platform was originally built using the MEN (Mongo, Node, Express) stack (see [Bricalot](https://github.com/jkups/bricalot)) and this is an attempt to build the solution using a different backend technology. The platform is mobile ready and was built with the following tools.

* Frontend
  * HTML, CSS, JavaScript / jQuery


* Backend
  * Ruby on Rails v5


* Libraries and Integration
  * Bootstrap v4
  * DataTables plugin
  * Braintree (card and paypal processing)
  * Google Places API
  * Cloudinary


### List of Features
##### 1. User and Account setup
You can setup a user profile on the platform. To make an investment though, you will be required to create an investment account. You can create unlimited number of investment accounts tied to a single user profile.

![Property List](https://drive.google.com/uc?export=view&id=1qjKrRfj9Jh4HdPMFM_DY0nXClxTFnHno)


Each property unit acquired is associated with an investment account making it possible to manage an investment portfolio across different investment philosophies under a single login credential.

#### 2. Payment Integration
The platform comes setup with two payment option - Credit/Debit Card and Paypal. All popular cards are accepted including MasterCard, Visa, AmericanExpress, etc.

#### 3. Investment Dashboard
All investment activity on each account is logged and a history of succesful transaction presented in a clear to understand dashboard. The dashboard shows a list of all investments that have been made on the account, how much was invested and fees paid. It also includes a summary at the account level.

![Investment](https://drive.google.com/uc?export=view&id=1SZQ2lPTDMH1vEz4B-afvii4NSmg3DsFN)

#### 4. Administration
A backend that allows an administrator to add properties and configure investment parameters like property value, location, minimum investment, etc. The backend also shows a detailed view of all transactions/investment and the associated investment account.

![Property List](https://drive.google.com/uc?export=view&id=1FvB9yr3T8jIow5SvxeAj7ppRAmV2SkY0)

### Demo Credentials
Mulka is live! Take it for a drive with these demo credentials.
* User Credentials:
  * john@gmail.com
  * password


* Admin Credentials:
  * admin@gmail.com
  * password

### TODO - Will get to this later... hopefully!
  1. Search function to filter listed properties
  2. A geocoded view of the property listing
  3. Logic to calculate dividend and investment returns
