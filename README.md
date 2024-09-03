# CSTV

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Xcode](https://img.shields.io/badge/Xcode-12.5-blue.svg)

CSTV is an iOS application designed to show CS2 matches info. This project is built using Swift and follows modern iOS development practices. Such as:
- MVVM architecture
- Combine
- Responsiveness
- Componetization
- Pagination
- Pull to refresh

Next improvements:
-  CI/CD
-  Localization

## Features

- Splash Screen: This screen will show the app logo, and should be displayed every time the app is launched for a given amount of time before the main screen is shown.
- List Screen: This screen will display a list of matches, beginning from the current date. The list should be sorted so that currently playing matches will appear on top. Each match will show basic data like the League, Teams, date and time, as well as its status. The status can be: Ended, In Progress, and Scheduled.
- Details Screen: This screen will appear when the user selects a match from the main screen. Aside from the data shown in the matches list, this will also display the players from each team, with their respective names, nicknames, and pictures.

## Requirements

- iOS 15.0+
- Swift 5.0+

## API
Go to https://pandascore.co/ and generate your own API Token.
Reference: https://developers.pandascore.co/reference

## Installation

To run this project on your local machine:

1. Clone the repository:
   ```bash
   git clone https://github.com/lucasbranddao/CSTV.git

2. Replace "{ Insert your Token }" by your own PandaScore Token
3. Run the App
