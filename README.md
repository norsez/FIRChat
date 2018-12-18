# FIRChat

A sample iOS serverless chat app that uses Firebase Database as the sole backend.



## Overview

The app is written with VIP clean architecture in mind in order to keep a one-way app flow.



### A Scene

```mermaid
sequenceDiagram
View ->> Interacter: user initiates an action
Interacter ->> FIR: triggers change in Firebase Database
FIR ->> Interacter: updates status with observer
Interacter ->> Presenter: asks to present a new state
Presenter ->> View: asks the view to present the state

```

![app architecture](https://github.com/norsez/FIRChat/blob/master/seqdiag.PNG?raw=true)

### Scenes

Each scene follows the above app flow. Each scene is represeted with its corresponding View (ViewController), interacter and presenter. There are two scenes in this project sample.

- Users 
  - shows who's online
  - allows user to select a conversation partner
- Conversations
  - allows chatting with the selected conversation parter
  - displays chat history

## Requirements

In order to run this sample project, you need to

- setup your Firebase free account
- create a Firebase app project 
- match the app bundle name of this sample project to your newly created Firebase app project



### How to run 

- Run a `pod install`in the sample project folder
- run FIRChat in Xcode 