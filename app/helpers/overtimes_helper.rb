module OvertimesHelper
  def get_project_name(id)
    return Project.find(id).name
  end
end
