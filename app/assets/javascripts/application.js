// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require sweet-alert
//= require jquery
//= require jquery_ujs
//= require sweet-alert-confirm
//= require jquery.multi-select
//= require turbolinks
//= require bootstrap-sprockets
//= require select2
//= require bootstrap-datepicker
//= require bootstrap-wysihtml5
//= require jquery.dataTables.min
//= require dataTables.bootstrap
//= require_tree .


$(window).bind('page:change', function() {
  initPage();
});
function initPage() {
  $('#menu-toggle').click(function(e) {
    $('#wrapper').toggleClass('toggled');
  });

  $('.panel').fadeIn(1000);
  $('.panel').hover(function(){
    $(this).find('.actions').fadeIn(500);
  });
  $('.panel').mouseleave(function(){
    $(this).find('.actions').fadeOut(200);
  });

  // tooltip
  $('[data-toggle="tooltip"]').tooltip()
  // end of tooltip

  // popover
  // $('[data-toggle="popover"]').popover({html:true})
  // end of popover

  var dontSort = [];
  var hidden = [];
  var sumIndex = -1;
  var sumType = 'count';
  $('.datatable thead th').each( function (index, elem) {
    // for sum up
    if ($(this).hasClass('sum_up')){
      sumIndex = index;
      if ($(this).hasClass('rmb')){
        sumType = 'rmb';
      }
    }
    // for no sort
    if ( $(this).hasClass( 'no_sort' )) {
      dontSort.push( { "bSortable": false } );
    } else {
      dontSort.push( null );
    }

    if ( $(this).hasClass('hidden')){
      hidden.push({"targets":[index], "visible":false})
    }
  });
$('.datatable').dataTable({
  "sDom": '<"row view-filter"<"col-sm-12"<"pull-left"l><"pull-right"f><"clearfix">>>t<"row"<"col-sm-12 text-center"<"total-footer">>><"row view-pager"<"col-sm-12"<"pagination-wrapper"p>>>',
  "aoColumns": dontSort,
  "autoWidth":false,
  "aaSorting": [],
  "columnDefs": hidden,
  "footerCallback": function ( row, data, start, end, display ) {
    if (sumIndex >= 0){
    var api = this.api();

            // Remove the formatting to get integer data for summation
            var intVal = function ( i ) {
              return typeof i === 'string' ?
              i.replace(/[￥ ]/g, '')*1 :
              typeof i === 'number' ?
              i : 0;
            };

            // Total over all pages
            total = api
            .column( sumIndex )
            .data()
            .reduce( function (a, b) {
              return intVal(a) + intVal(b);
            } );

            // Total over this page
            pageTotal = api
            .column( sumIndex, { page: 'current'} )
            .data()
            .reduce( function (a, b) {
              return intVal(a) + intVal(b);
            }, 0 );
            var totalStr = '';
            if (sumType == 'rmb'){
              pageTotal = parseInt(pageTotal*100)/100.0;
              total = parseInt(total*100)/100.0;
              totalStr = '本页小计: ￥'+pageTotal +' / 总计: ￥'+ total;
            }else{
              pageTotal = parseInt(pageTotal*10)/10.0;
              total = parseInt(total*10)/10.0;
              totalStr = '本页小计: '+pageTotal +' / 总计: '+ total;

            }

            $('.total-footer').html(totalStr);
            // Update footer
            // $( api.column( sumIndex ).footer() ).html(totalStr);
          }
        }
});
}
