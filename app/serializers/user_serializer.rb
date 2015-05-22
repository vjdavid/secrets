class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :email,
    :current_project_id,
    :role
  )
end
