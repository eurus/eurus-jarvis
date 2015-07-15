module ProjectsHelper
  def supervisor_name(id)
    "#{User.find(id).try :email}"
  end
  def owner_name(id)
    "#{User.find(id).try :nickname}"
  end
end
