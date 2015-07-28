code = '<%= code %>'
id = '<%= id %>'
status = '<%= status %>'
if code == "ok"
  sweetAlert "Update successfully!"
  $("#plan-status-#{id}").html status
else
  sweetAlert "(╯‵□′)╯︵┻━┻"

