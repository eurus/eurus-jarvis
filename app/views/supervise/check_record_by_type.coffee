cut = '<%= cut%>'
id = '<%= id%>'
atime = '<%= approve_time %>'
item_str = "#check-#{cut}-#{id}"
row_str = "#tr-#{cut}-#{id}"
status_str = "#tr-status-#{cut}-#{id}"
time_str = "#tr-approve-time-#{id}"
$(status_str).html "已审核"
$(time_str).html atime
$(item_str).remove()
$(status_str).addClass('warning')

