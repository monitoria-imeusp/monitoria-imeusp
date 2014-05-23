module ApplicationHelper
  def show_yes_or_no(boolean_value)
    boolean_value ? 'Sim' : 'Não'
  end
end
