{VRComponent, VRLayer} = require "VRComponent"

vr = new VRComponent
	distance: 2000
	perspective: 1200
# 	clip: false
	cubeSide: 2600

# 	front: "images/front.jpg"
	left: "images/left.jpg"
	right: "images/left.jpg"
	back: "images/left.jpg"
	top: "images/top.jpg"
	bottom: "images/bottom.jpg"


vr.hideEnviroment()



Utils.insertCSS('@import url("https://rsms.me/inter/inter-ui.css")')
Framer.Extras.Preloader.enable()
Framer.Extras.Preloader.setLogo('https://i.imgur.com/zmgXGaA.png')
Framer.Extras.Hints.disable()

Framer.Info =
	author: "Callil Capuozzo, Leander Capuozzo"
	twitter: "@_callil @leandercapuozzo"
	title: "SAUSHAXSUNRISEHUNTER"
	


itemIDs = 
	[
		"6886724173883", #a1
		"6886724206651", 
		"6886724239419",
		"6886724304955",
		"6886724337723",
		"6886724370491", 
		"6886724403259", 
		"6886724468795",
		"6886724501563", 
		"6887550058555",
		"6886724567099", 
		"6886724599867", 
		"6886724632635", #b1
		"6886724665403", 
		"6886724698171",
		"6886724730939", 
		"6886724763707",
		"6886724796475", 
		"6886724829243", 
		"6886724894779", 
		"6886724927547", 
		"6886724534331",
		"6886724960315", 
		"6886724993083", 
		"6886725058619", #c1
		"6886725091387", 
		"6886725124155", 
		"6886725156923", 
		"6886725189691", 
		"6886725222459", 
		"6886725255227", 
		"6886725287995", 
		"6886725320763", 
		"6886725353531", 
		"6886725386299", 
		"6886725419067", 
		"6886725451835", #d1
		"6886725484603", 
		"6886725615675",
		"6886725648443",
		"6886725681211", 
		"6886725713979", 
		"6886725746747", 
		"6886725779515", 
		"6886725812283", 
		"6886725845051", 
		"6886725910587", 
		"6886725943355", 
		"6886725976123", #e1
		"6886726008891", 
		"6886726074427", 
		"6886726107195", 
		"6886726139963", 
		"6886726205499", 
		"6886726238267", 
		"6886726271035", 
		"6886726303803", 
		"6886726336571", 
		"6886726369339", 
		"6886726402107", 
		"6886726434875", #f1
		"6886726467643", 
		"6886726500411", 
		"6886726533179", 
		"6886726565947", 
		"6886726598715",
		"6886726631483", 
		"6886726664251", 
		"6886726697019",
		"6886726729787", 
		"6886726762555", 
		"6886726795323", 
		"6886726828091", #g1
		"6886726860859", 
		"6886726926395", 
		"6886726959163", 
		"6886726991931", 
		"6886727024699", 
		"6886727057467", 
		"6886727090235", 
		"6886727123003", 
		"6886727155771", 
		"6886727188539", 
		"6886727221307", 
		"6886727254075", #h1
		"6886727286843", 
		"6886727319611", 
		"6886727352379", 
		"6886727385147", 
		"6886727417915", 
		"6886727450683", 
		"6886727483451", 
		"6886727516219", 
		"6886727548987", 
		"6886727581755", 
		"6886727614523", 
		"6886727647291", #i1
		"6886727680059", 
		"6886727712827", 
		'6886727745595', 
		"6886727778363", 
		"6886727811131", 
		"6886727843899",
		"6886727876667", 
		"6886727909435", 
		"6886727942203", 
		"6886727974971", 
		"6886728040507" 
	]
	
currentTooltipID = 0
if Utils.isChrome()
	document.body.style.cursor = "-webkit-grab"
else if Utils.isSafari()
	document.body.style.cursor = "grab"

Screen.backgroundColor = "white"
tooltipFound = false
crntTpHeading = 0
crntTpElevation = 0
currentTooltipID = 0

# DVDs
tileCount = 1
columnCount = 1
gutter = 1

combinedGutterWidth = gutter * (columnCount - 1)
combinedTileWidth = Screen - combinedGutterWidth
tileWidth = combinedTileWidth / columnCount
tileOffset = tileWidth + gutter

layerArray = []

# Loop to create grid tiles
for index in [0...tileCount]
	columnIndex = (index % columnCount)
	rowIndex = columnCount - Math.floor(index / columnCount)
	
	tileContainer = new VRLayer
		name: index
		backgroundColor: ''
		height: 228
		width: 168
		distance: 1200
		scale: .75

	tile = new Layer
		parent: tileContainer
		size: tileContainer.size
		height: 451
		width: 388
		x: Align.center
		y: Align.center
		clip: false
		image: "images/dvd/final.png"
	
	tileContainer.heading = -0 + (columnIndex*0)
	tileContainer.elevation = -0 + (rowIndex*0)
	
	vr.projectLayer(tileContainer)
	layerArray.push(tileContainer)

reticle = new Layer
	width: 80
	height: 80
	borderRadius: 40
	backgroundColor: "transparent"
	shadowBlur: 4
	shadowSpread: 1
	shadowColor: "rgba(0,0,0,0.1)"
	scale: 0.25
	borderWidth: 10
	borderColor: 'white'
reticle.center()

reticleScaleUp = new Animation
	layer: reticle
	properties: 
		scale: 0.35
		borderColor: 'orange'
	time: 0.1
# 	curve: "linear"
	
reticleScaleDown = new Animation
	layer: reticle
	properties: 
		scale: 0.25
		borderColor: 'white'
	time: 0.1
# 	curve: "linear"

#Layer scaling
tooltipActivator = (currentTooltip) ->
	Utils.delay .3, ->
		layerArray[currentTooltip].animate
			properties: 
				scale: .75
				distance: 1200
			time: 0.1
			curve: Bezier.ease

tooltipDisabler = (currentTooltip) ->
	Utils.delay .3, ->
		layerArray[currentTooltip].animate
			properties: 
				scale: .75
				distance: 1200
			time: 0.1
			curve: Bezier.ease

#Select DVDs

vr.onOrientationChange (data) ->
	heading = data.heading
	elevation = data.elevation
	tilt = data.tilt
	
	#Tooltip behaviour
	for i in [0...layerArray.length]
		triggerDistance = 2.2
		headingProximity = Math.abs(heading - layerArray[i].heading)
		elevationProximity = Math.abs(elevation - layerArray[i].elevation)
		if (headingProximity < triggerDistance)
			if (elevationProximity < triggerDistance)
				if (tooltipFound is false)
					currentTooltipID = i
					reticleScaleUp.start()
					tooltipActivator(currentTooltipID)
					crntTpHeading = layerArray[i].heading
					crntTpElevation = layerArray[i].elevation
					tooltipFound = true
					onTooltipFound(crntTpHeading, crntTpElevation)
		if (tooltipFound is true)
			if (Math.abs(heading - crntTpHeading) > triggerDistance)
				reticleScaleDown.start()
				tooltipDisabler(currentTooltipID)
				tooltipFound = false
				onTooltipLost()
			else if (Math.abs(elevation - crntTpElevation) > triggerDistance)
				reticleScaleDown.start()
				tooltipDisabler(currentTooltipID)
				tooltipFound = false
				onTooltipLost()

#Clicks and taps

butt = null
idURL = 6874276593723

onTooltipFound = (currentToolTipHeading, currentTooltipElevation) ->
	if Utils.isMobile()
		buy.text = "TAP TO BUY"
	else
		buy.text = "CLICK TO BUY"
		
	for item in layerArray
		if item.name != currentTooltipID.toString()
			item.animate
				scale: .75
				distance: 1200
				options:
					time: .3
					
	if Utils.isMobile()
		layerArray[currentTooltipID].onTouchStart ->
			if this.name == currentTooltipID.toString()
				this.animate
					scale: .85
					options:
						time: .3
					
		layerArray[currentTooltipID].onTouchEnd ->
			if this.name == currentTooltipID.toString()
				this.animate
					scale: .75
					options:
						time: .3
				window.location = "https://opensea.io/assets/0x4ba9e93337235a5a3e85abb77a7ef2898cff0608/3143"
		
	if Utils.isDesktop()
		layerArray[currentTooltipID].onMouseDown ->
			if this.name == currentTooltipID.toString()
				this.animate
					scale: .75
					options:
						time: .3	
				
		layerArray[currentTooltipID].onTapEnd ->
			if this.name == currentTooltipID.toString()
				this.animate
					scale: .75
					options:
						time: .3
				window.location = "https://opensea.io/assets/0x4ba9e93337235a5a3e85abb77a7ef2898cff0608/3143"
		
		layerArray[currentTooltipID].onMouseOver ->
			if this.name == currentTooltipID.toString()
				this.animate
					scale: .85
					options:
						time: .3
				document.body.style.cursor = "pointer"
		
		layerArray[currentTooltipID].onMouseOut ->
			document.body.style.cursor = "grab"
			if Utils.isChrome()
				document.body.style.cursor = "-webkit-grab"
			if this.name == currentTooltipID.toString()
				this.animate
					scale: .75
					options:
						time: .3
	

#Do stuff if reticle is out of a tooltip
onTooltipLost = ->
	currentTooltipID = 10000
	if Utils.isMobile()
		buy.text = "MOVE TO SELECT"
	else
		buy.text = "DRAG TO SELECT"



#text
testLayer = new TextLayer
	width: Screen.width
	text: ""
	x: Align.center
	textAlign: 'center'
	color: 'black'
	fontWeight: 'bold'
	padding: 10
	fontFamily: "Inter UI"

buy = new TextLayer
	width: Screen.width
	text: "MOVE TO SELECT"
	x: Align.center
	textAlign: 'center'
	fontWeight: 'bold'
	color: 'black'
	padding: 10
	fontFamily: "Inter UI"
	y: Screen.height - 75
	
if Utils.isMobile()
	buy.text = "MOVE TO SELECT"
else
	buy.text = "DRAG TO SELECT"

#walls
poster = new Layer
	width: 1200
	height: 1200
	scale: .3
	image: "images/side1.png"
	
poster.heading = 270
poster.elevation = 0

vr.projectLayer(poster)

	
poster2 = new Layer
	width: 1200	
	height: 1200
	scale: .3
	image: "images/side2.png"
	
poster2.heading = 90
poster2.elevation = 0

vr.projectLayer(poster2)


floor = new Layer
	width: 754
	height: 972
	image: "images/bottom.jpg"
	
floor.heading = 0
floor.elevation = -90

vr.projectLayer(floor)

back = new Layer
	width: 1200
	height: 1200
	scale: .3
	image: "images/side3.png"
	
back.heading = 180
back.elevation = 0

vr.projectLayer(back)

top = new Layer
	size: 100
	image: "images/smile.png"
	
top.heading = 0
top.elevation = 90

vr.projectLayer(top)
