cut = '<%= cut%>'
id = '<%= id%>'
item_str = "#issue-#{cut}-#{id}"
row_str = "#tr-#{cut}-#{id}"
status_str = "#tr-status-#{cut}-#{id}"
$(status_str).html "已发放"
$(item_str).remove()
$(row_str).removeClass('warning')
$(status_str).addClass('success')
