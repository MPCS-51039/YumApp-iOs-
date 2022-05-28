# Yum Produce
This repo contains the final project for the Mobile Software Engineering course MPCS 51039. 
The app provides users with a simple interfase to create a list of produuce items they currently have at home and are pending to eat. The Home Screen shows a list of produce and an option to view a seasonally filtered list. The app shows produce season and recommendations for storage. A user can easily add new items from any screen in the apap to "My Kitchen", where htey can view what they have at home and remove any items consumed. 

## Video and Screenshots
[Here](https://www.youtube.com/watch?v=IQK772iKExQ) is a video that shows the app's functionality and below are a few screenshots of what the app pages look like. 

Initial Home Screen with:
List of All Produce and seasonal selection option
Access to "My Kitchen" (cutlery icon)
* <img width="212" alt="home" src="https://user-images.githubusercontent.com/83419562/170388668-c3237d05-2955-4071-95b0-3b6d92ff4930.png">


View of Year-Round Selection:

<img width="211" alt="year" src="https://user-images.githubusercontent.com/83419562/170388677-2b415ea4-912d-456e-a174-fc30c7e9bbda.png">


View of "Summer" selection:

<img width="213" alt="summ" src="https://user-images.githubusercontent.com/83419562/170388859-1478a4c5-789a-4c24-95ae-b297683262fa.png">


Trailing Swipe to add item to My Kitchen:

<img width="216" alt="summeradd" src="https://user-images.githubusercontent.com/83419562/170388881-50307571-ea63-426e-ac72-bf288635832e.png">


View of items in My Kitchen:

<img width="210" alt="Mykitt" src="https://user-images.githubusercontent.com/83419562/170388895-9c8ae47b-6843-4ed1-830a-683f38294185.png">


Trailing Swipe to remove item from My Kitchen: Yum!

<img width="211" alt="mykityum" src="https://user-images.githubusercontent.com/83419562/170388918-43a6909c-e92f-48ca-9c34-13e4c43185e2.png">

# How to Run the App
1. Clone this repo https://github.com/MPCS-51039/ios-project-mariswb.git
2. Open the YumProduce project in Xcode.
3. Run the app on the simulator.

# Project Proposal Description

Initially, there were several additional features for each produce, the rating and status (which was to be whether it needed to be eaten / had been eaten). 

Proposed functionality:
1. Ability to add an item to "My Kitchen" from a list of produce
2. See produce by season
3. Set item to pending to eat if in My Kitchen, remove when eaten.
4. Keep track of what items and when they were eaten
5. The rating was intended to track users "like" of the item
6. Offer eating suggestions based on storage time and time in fridge


# Result
- The app can perform functionalities 1, 2, and 3.
- The app does not track user history and so, does not track item frequency and timeframe.
- Rating the item stopped making sense, food is not something people that forget how they feel about, so produce raating was aattempted and deprecated (attempt in branch _ios-custom-feature_ of this repo)

# Next Steps
- Decide on title in homepage: YumProduce or GoodProduce (initially Yum and Good had different characteristics that were not built out).
- Improvements for landscape orientation and other sized devices.
- Review of Home Page visual design for seasonal cells to not require swipe and smaller row cells to fit more produce in.
- Implement search bar (makes more sense instead of scrolling through list)
- Add section for user to add recipe links (and possibly a rating for each recipe they save on an item).
- Connect to a real API to source a full list of produce items. Maybe include other perishables such as grains, legumes, nuts, herbs and animal products. 


#### Please leave a comment with your thoughts! Very appreciated!

