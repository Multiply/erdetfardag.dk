# Google setup
calendarUrl  = 'https://www.google.com/calendar/feeds/tsfg1ml3g2l293ejpfgq8jedo4%40group.calendar.google.com/public/full'
service      = false
query        = false
serviceQueue = []
window._gaq  = _gaq = [
	['_setAccount'   , 'UA-18291722-10']
	['_setDomainName', 'erdetfardag.dk']
	['_trackPageview']
]

google.setOnLoadCallback ->
	# Analytics Script Element
	ga = document.createElement 'script'
	ga.async = true
	ga.src   = 'http://www.google-analytics.com/ga.js'

	s = document.getElementsByTagName('script')[0]
	s.parentNode.insertBefore ga, s

	# Calendar service and query
	service = new google.gdata.calendar.CalendarService 'erdetfardag-app'
	query   = new google.gdata.calendar.CalendarEventQuery calendarUrl

	# If we have queue'd items, go over them again, now that we have a calendar service
	isIt item for item in serviceQueue
	serviceQueue = []

google.load 'gdata', '1'

isIt = (cb) ->
	# If we don't have a calendar service yet, queue the callbacks
	if service
		now = moment().startOf 'day'
		query.setMinimumStartTime now.format 'YYYY-MM-DD'
		query.setMaximumStartTime now.add('days', 1).format 'YYYY-MM-DD'

		service.getEventsFeed query, (root) ->
			cb root.feed.getEntries().length
	else
		serviceQueue.push cb

# jQuery and Bootstrap setup
$ ->
	buttonPrimary = $ '.btn-primary'
	buttonSuccess = $ '.btn-success'
	buttonWarning = $ '.btn-warning'

	buttonPrimary.popover
		placement : 'top'
		html      : true
		trigger   : 'manual'

	buttonSuccess.popover
		placement : 'top'
		html      : true
		trigger   : 'manual'

	buttonWarning.popover
		placement : 'top'
		html      : true
		trigger   : 'manual'

	buttonPrimary.click ->
		buttonSuccess.popover 'hide'
		buttonWarning.popover 'hide'
		isIt (bool) ->
			_gaq.push ['_trackEvent', 'Clicks', 'Answers', 'Yes', if bool then 'Correct' else 'Wrong']
			buttonPrimary.attr 'data-content', if bool then "Du har ret, det er fardag!" else "Ehm, hvad? Nej, det er ikke fardag i dag!"
			buttonPrimary.popover 'toggle'

	buttonSuccess.click ->
		buttonPrimary.popover 'hide'
		buttonWarning.popover 'hide'
		isIt (bool) ->
			_gaq.push ['_trackEvent', 'Clicks', 'Answers', 'No', unless bool then 'Correct' else 'Wrong']
			buttonSuccess.attr 'data-content', if bool then "Wtf? Jo, det ER fardag!" else "Du har ret! Det er nemlig IKKE fardag i dag!"
			buttonSuccess.popover 'toggle'

	buttonWarning.click ->
		_gaq.push ['_trackEvent', 'Clicks', 'Answers', 'Stupid']
		buttonPrimary.popover 'hide'
		buttonSuccess.popover 'hide'
		buttonWarning.attr 'data-content', "Ja, du er sgu for dum.<br>Prøv Google!"
		buttonWarning.popover 'toggle'
