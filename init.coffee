isIt = ->
	now = moment()
	day = now.day()

	day is 3 or (now.isoWeek() % 2 is 0 and (day is 5 or day is 6 or day is 0))

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
		buttonPrimary.attr 'data-content', if isIt() then "Du har ret, det er fardag!" else "Ehm, hvad? Nej, det er ikke fardag i dag!"
		buttonPrimary.popover 'toggle'

	buttonSuccess.click ->
		buttonSuccess.attr 'data-content', if isIt() then "Wtf? Jo, det ER fardag!" else "Du har ret! Det er nemlig IKKE fardag i dag!"
		buttonSuccess.popover 'toggle'

	buttonWarning.click ->
		buttonWarning.attr 'data-content', "Ja, du er sgu for dum.<br>Prøv Google!"
		buttonWarning.popover 'toggle'
