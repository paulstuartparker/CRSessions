ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :location_id

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :location
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :select, collection: User.roles.keys
      f.input :location
    end
    f.actions
  end
end
