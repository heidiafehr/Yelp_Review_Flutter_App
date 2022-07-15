//what widgets I want to test and why
  //display expanded hours with header
    //if price and type are/are not valid
      //are - displays what it needs to display
      //are not - Text widget is not there?
    //if hours are/are not valid
      //are - displays restaurant hours (widget is there)
      //are not - displays restaurant hours is not there??
        //but would this be necessary if we guarantee that hours should be valid
        //in order to call this widget?
  //display restaurant hours
    //what eliza did?
  //display overall rating
    //if rating is/is not null
      //is - does not have either widgets to display anything
      //is not - displays what it needs to display
  //display price alias and open status
      //if priceAndType are/are not valid
        //are - has priceAndAlias widget?
        //are not - both spacer and price and alis are not there
      //if isOpenNow is/is not null
        //is - does not have openStatus widget
        //is not - has openStatus widget
  //display user reviews
      //if total number of review is/is not null
        //is - does not display anything
        //is not - displays the total number reviews text
      //text is/is not valid
        //is - displays text
        //is not - displays sizedbox.shrink
      //if user image URL is/is not null
        //is - displays the Initicon widget
        //is not - displays the network image
  //restaurant image carousel