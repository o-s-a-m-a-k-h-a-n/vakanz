$(function() {
  $('input[name="daterange"]').daterangepicker({
    locale: {
      format: 'YYYY-MM-DD'
    },
    startDate: '2013-01-01',
    endDate: '2013-12-31',
    minDate: moment() 
    // prevents customer from picking a date and time prior to current date and time
    });
});