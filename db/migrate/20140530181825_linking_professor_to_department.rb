class LinkingProfessorToDepartment < ActiveRecord::Migration
    def up
        change_table :professors do |t|
            t.rename :department, :department_tmp
            t.belongs_to :department
        end

        Professor.all.each do |p|
            d = Department.find_by({"code" => p.department_tmp})
            if not d
                d = Department.create!({"code" => p.department_tmp})
            end
            p.department_id = d.id
            p.save
        end

        change_table :professors do |t|
            t.remove :department_tmp
        end
    end

    def down
        add_column :professors, :department_tmp, :string

        Professor.all.each do |p|
            d =  Department.find(p.department_id)
            if not d
                d = Department.create!({"code" => "", "id" => p.department_id})
            end
            p.department_tmp = d.code
            p.save
        end

        change_table :professors do |t|
            t.remove :department_id
            t.rename :department_tmp, :department
        end
    end
end
