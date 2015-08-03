code = '<%= code %>'
id = '<%= id %>'
status = '<%= status %>'

switch status
  when "ontime"
    hover_sytle = "success"
  when "overtime"
    hover_sytle = "danger"
  else
    hover_sytle = ""
  
if code == "ok"
  sweetAlert "Update successfully!"
  $("#plan-status-#{id}").html status
  $("#plan-status-#{id}").removeAttr('class')
  $("#plan-status-#{id}").addClass(hover_sytle)

else
  sweetAlert "(╯‵□′)╯︵┻━┻","Calm down, Bro"

