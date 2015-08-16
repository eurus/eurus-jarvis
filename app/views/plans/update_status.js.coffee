code = '<%= code %>'
id = '<%= id %>'
statusCode = '<%= statusCode %>'
status = '<%=status%>'

switch statusCode
  when "ontime"
    hover_style = "success text-center"
  when "overtime"
    hover_style = "danger text-center"
  else
    hover_style = "text-center"

if code == "ok"
  sweetAlert "Update successfully!"
  $("#plan-status-#{id}").html status
  $("#plan-status-#{id}").removeAttr('class')
  $("#plan-status-#{id}").addClass(hover_style)

else
  sweetAlert "(╯‵□′)╯︵┻━┻","Calm down, Bro"

