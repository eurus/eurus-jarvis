cut = '<%= cut%>'
id = '<%= id%>'
item_str = "#check-#{cut}-#{id}"
row_str = "#tr-errand-#{id}"
$(item_str).remove()
$(row_str).addClass('warning')

