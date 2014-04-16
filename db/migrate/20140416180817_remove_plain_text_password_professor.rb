class RemovePlainTextPasswordProfessor < ActiveRecord::Migration
  def change
      change_table :professors do |t|
          t.remove :password
      end
  end
end
