cut = '<%= cut%>'
id = '<%= id%>'
item_str = "#check-#{cut}-#{id}"
row_str = "#tr-#{cut}-#{id}"
status_str = "#tr-status-#{cut}-#{id}"
$(status_str).html "已审核"
$(item_str).remove()
$(status_str).addClass('warning')

