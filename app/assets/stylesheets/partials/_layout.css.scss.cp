@import "susy_framework";
@import "compass/utilities";
@import "compass/css3/border-radius";

$search_ui_border_color: #AAAAAA;
$search_ui_bg_color: #d3d2d0;

/* Generic layout stuff */
.hide 
{
  display:none
}

/* Global */
body 
{
  background: #d3d2d0 asset_url('blacklight/bg-5px.jpg',image) repeat-x top left; 
  font: 12px Verdana, "Lucida Grande", "Lucida Sans Unicode", "Arial Unicode MS", Arial, sans-serif; 
  line-height: 1.4; 
  margin: 0px; 
  padding: 15px;
}

/* Header Container Layout */
#page 
{ 
  @include container;
  margin: 0px auto;
}

#collection
{
   color:#e4e4e4;
   font-size:12px;
   font-style:italic;
}

#blog
{
  color:#e4e4e4;
  font-size:12px;
  font-style:italic;
}

#hd 
{
  padding: 0px 60px 0px 60px;
  height: 122px;
  width: inherit;
 
  #logo
  {
   width: inherit;
   height: 122px;
  }

  #top_search
  {
   float: right;
   position: absolute;
   margin-left: 600px;
   margin-top: 13px;
   margin-bottom: 12px;
   }

  .bostontvnews-logo {
   padding-top: 47px;
   float: left;
  }
  
  .top-dates-logo {
   float: left;
  }
}

#bd 
{
  @include container;
  @include clearfix;
  margin-bottom: 2em;
  padding: 20px 60px 0px 60px;

  #main 
  {
   display: inline;
   float: right;
   margin-right: 0;
   padding-left: 20px;
   padding-top: 25px;
   padding-right: 20px;
   width: 684px;
  }

  #sidebar 
  {
    width: 300px;
    float: left;
    margin-right: 20px;

    p 
    { 
      padding-top: 20px;
    }
  }
}

#ft {
  @include full;
  @include clearfix;
}


