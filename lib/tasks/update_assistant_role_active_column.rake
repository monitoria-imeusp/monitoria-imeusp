desc "Updates 'active' status of all Assistant Roles to true."

task :update_assistant_role_active_column => [:environment] do
  AssistantRole.all.each do |assistant_role| 
    if assistant_role.active.nil?
      assistant_role.update_column(:active, true)
    end
  end
end
