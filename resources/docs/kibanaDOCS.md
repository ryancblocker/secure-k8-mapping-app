# How to filter through a data set in Kibana

### This documentation assumes you have a kibana instance up and running!

####

#### Log into your kibana instance

#### Navigate to the three horizontal lines on the left

Scroll down to the left side and under 'Analytics', click on the link that says "MAPS"

#### This should take you to a map! Now, navigate to the right hand side where it says "add layer". From there, you will add a GEOJSON file of choice (in our case it is universitys)

####

The data should automatically be loaded! Now, make sure to scroll down and click on the "import file" then add as a document layer

#### Now, name the layer whatever you want

##### How to add a tooltip

A tooltip allows it so when you click on the dot, the information about it comes up. Click the button that says "add", then add the fields you want. For this project, I added CITY, NAME, STATE.

#### Now filtering the different states by color

In your layer, go to "Layer Style", then under fill color, ckucj on "marker". After this, go to color pallete and click on custom color pallete.

After this, you will mark a "fill color" by value and that value will be STATE.keyword. you will create a color for the 50+ states/territories.Kibana should take care of the actual colors for you. When this is done, make sure to click save in the top right corner. (Only do this when we are demoing. It is redudant and uneccasary if not demoing)

### Saving to a dashboard

After clicking the blue save button in the top right, it will bring you to box that says "Save map". You will title it and change the "add to dashboard" from existing to "new" and then click "save and go to dashboard"

#### Working within the dashboard

After saving, you will be taken to your new dashboard page. The first thing to do would be extend your map to full size. To do this, find the bottom right map and extend.

#### How to embed iFrame into Kibana

Now, you will navigate to the button that says "share". From there, click on the top and click on "embed" code. Generate the link as "Snapshot". From there you will include Filter Bar and Query. Then click "copy iFrame" link at paste it into html page.

### Integrating a bounding box to filter data

Click on the wrench on the left side of the map. Choose one of the three options " You are in a dialog. Press Escape, or tap/click outside the dialog to close.

```
Tools

Draw shape to filter data

Draw bounds to filter data

Draw distance to filter data
```

Under geometry label, name filter what you want, then you choose whichever spatial relation you want to. (I usually do within), then click "Draw Shape" Draw shape. After this, a filter will be made. If you want to change the name/settings, click on "edit filter"

### Getting a "cluster" map into kibana

On ur map under layers, there should be a big blue button that says "ADD LAYER". After this, scroll down to the page that says "Clusters".

It will ask you to select data view, you will select the data set you made the when you did the previous steps. The cluster field will be geometry and you will be able to choose between clusters and grids.

Then, click add and continue. Name your layer, then under "aggregation" is count. For now, that just gives us a cluster map. The toolkit is TBD.

Now, save as mentioned in the earlier documenation!

### How to turn the clusters into points (Switching from layer to layer with zoom setting)

Edit your layers, the cluster layer's zoom levels should be "0 --> 9" and your dot layers should be "9 --> 24" Save this and thats all you need to do. You should see that you can edit this right under where you name your layer. 

### How To Add An Initial Location to Kibana and Enable GEOJSON Data Related to Zoom Functionality

1. From the dashboard, go to settings on the map by clicking the gear icon and clicking edit map from the options menu. s
2. Scroll to the navigation section on the settings menu
3. Under Initial map location enable Fixed location
   1. Set initial latitude to 39.742043 and initial longitude to -104.991531 which will set the initial location when the elastic map loads to Denver, CO
4. Set the initial zoom to 13. Any initial zoom above this value will cause the map to be too zoomed in
5. At the bottom of the screen click keep changes and then at the top right click save and return to return to the dashboard
6. From the dashboard go to the options menu again, this time clicking the more menu option
7. From there click on Filter dashbaord by map bounds. This change works as you zoom and pan the map, the dashboard updates to display only the data visible in the map bounds



#### Congrats :)
