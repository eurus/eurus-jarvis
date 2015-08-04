cut = '<%= cut%>'
id = '<%= id%>'
item_str = "#issue-#{cut}-#{id}"
row_str = "#tr-errand-#{id}"
$(item_str).remove()
$(row_str).removeClass('warning')
$(row_str).addClass('success')
