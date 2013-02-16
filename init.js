// Generated by CoffeeScript 1.4.0
(function() {
  var calendarUrl, isIt, query, service, serviceQueue;

  calendarUrl = 'https://www.google.com/calendar/feeds/tsfg1ml3g2l293ejpfgq8jedo4%40group.calendar.google.com/public/full';

  service = false;

  query = false;

  serviceQueue = [];

  google.setOnLoadCallback(function() {
    var item, _i, _len;
    service = new google.gdata.calendar.CalendarService('erdetfardag-app');
    query = new google.gdata.calendar.CalendarEventQuery(calendarUrl);
    for (_i = 0, _len = serviceQueue.length; _i < _len; _i++) {
      item = serviceQueue[_i];
      isIt(item);
    }
    return serviceQueue = [];
  });

  google.load('gdata', '1');

  isIt = function(cb) {
    var now;
    if (service) {
      now = moment().startOf('day');
      query.setMinimumStartTime(now.format('YYYY-MM-DD'));
      query.setMaximumStartTime(now.add('days', 1).format('YYYY-MM-DD'));
      return service.getEventsFeed(query, function(root) {
        return cb(root.feed.getEntries().length);
      });
    } else {
      return serviceQueue.push(cb);
    }
  };

  $(function() {
    var buttonPrimary, buttonSuccess, buttonWarning;
    buttonPrimary = $('.btn-primary');
    buttonSuccess = $('.btn-success');
    buttonWarning = $('.btn-warning');
    buttonPrimary.popover({
      placement: 'top',
      html: true,
      trigger: 'manual'
    });
    buttonSuccess.popover({
      placement: 'top',
      html: true,
      trigger: 'manual'
    });
    buttonWarning.popover({
      placement: 'top',
      html: true,
      trigger: 'manual'
    });
    buttonPrimary.click(function() {
      buttonSuccess.popover('hide');
      buttonWarning.popover('hide');
      return isIt(function(bool) {
        buttonPrimary.attr('data-content', bool ? "Du har ret, det er fardag!" : "Ehm, hvad? Nej, det er ikke fardag i dag!");
        return buttonPrimary.popover('toggle');
      });
    });
    buttonSuccess.click(function() {
      buttonPrimary.popover('hide');
      buttonWarning.popover('hide');
      return isIt(function(bool) {
        buttonSuccess.attr('data-content', bool ? "Wtf? Jo, det ER fardag!" : "Du har ret! Det er nemlig IKKE fardag i dag!");
        return buttonSuccess.popover('toggle');
      });
    });
    return buttonWarning.click(function() {
      buttonPrimary.popover('hide');
      buttonSuccess.popover('hide');
      buttonWarning.attr('data-content', "Ja, du er sgu for dum.<br>Prøv Google!");
      return buttonWarning.popover('toggle');
    });
  });

}).call(this);
