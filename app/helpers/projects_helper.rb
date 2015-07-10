module ProjectsHelper
  def owner_name(id)
    "#{User.find(id).try :nickname}"
  end
end
