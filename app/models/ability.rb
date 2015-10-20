class Ability
  include CanCan::Ability

  def initialize(user)
    if user == nil #user is not logged in
      cannot :read, Admin
      cannot :update, Admin
      cannot :read, Dump
      cannot :create, Professor
      cannot :read, Professor
      cannot :update, Professor
      cannot :destroy, Professor
      cannot :create, Secretary
      cannot :read, Secretary
      cannot :update, Secretary
      cannot :destroy, Secretary
      cannot :create, Student
      cannot :read, Student
      cannot :update, Student
      cannot :destroy, Student
      cannot :create, Course
      can :read, Course
      cannot :update, Course
      cannot :destroy, Course
      cannot :create, RequestForTeachingAssistant
      cannot :read, RequestForTeachingAssistant
      cannot :update, RequestForTeachingAssistant
      cannot :destroy, RequestForTeachingAssistant
      cannot :create, Candidature
      cannot :read, Candidature
      cannot :update, Candidature
      cannot :destroy, Candidature
    elsif user.is_a? Admin
      can :read, Admin
      can :update, Admin
      can :control_panel, Admin
      can :register_undergraduate_courses, Admin
      can :register_postgraduate_courses, Admin
      can :duplicate_students, Admin
      can :read, Dump
      can :create, Professor
      can :read, Professor
      cannot :update, Professor
      can :destroy, Professor
      can :create, Secretary
      can :read, Secretary
      can :update, Secretary
      can :destroy, Secretary
      cannot :create, Student
      can :read, Student
      cannot :update, Student
      can :destroy, Student
      can :create, Course
      can :read, Course
      can :update, Course
      can :destroy, Course
      can :create, RequestForTeachingAssistant
      can :read, RequestForTeachingAssistant
      can :update, RequestForTeachingAssistant
      can :destroy, RequestForTeachingAssistant
      can :index_for_semester, RequestForTeachingAssistant
      can :create, Candidature
      can :read, Candidature
      can :update, Candidature
      can :destroy, Candidature
    elsif user.is_a? User and user.professor? #Professor
      cannot :read, Admin
      cannot :update, Admin
      can :read, Professor
      can :update, Professor #, :id => user.id #Only himself
      can :create, Professor 
      can :change_password, Professor #, :id => user.id #Only himself
      can :destroy, Professor #, :id => user.id #Only Himself
      cannot :create, Secretary
      can :read, Secretary
      cannot :update, Secretary
      cannot :destroy, Secretary
      cannot :create, Student
      can :read, Student
      cannot :update, Student
      cannot :destroy, Student
      can :read, Course
      can :create, RequestForTeachingAssistant
      can :read, RequestForTeachingAssistant #, :professor_id => user.id #Only his own
      can :update, RequestForTeachingAssistant #, :professor_id => user.id #Only his own
      can :destroy, RequestForTeachingAssistant #, :professor_id => user.id #Only his own
      can :index_for_semester, RequestForTeachingAssistant
      if user.super_professor?
        can :read, Dump
        can :create, Professor
        can :create, Course
        can :update, Course
        can :destroy, Course
        can :create, Candidature
        can :read, Candidature
        can :update, Candidature
        can :destroy, Candidature
        can :make_superprofessor, Professor
      else
        cannot :read, Dump
        cannot :create, Professor
        cannot :create, Course
        cannot :update, Course
        cannot :destroy, Course
        cannot :create, Candidature
        cannot :read, Candidature
        cannot :update, Candidature
        cannot :destroy, Candidature
      end
    elsif user.is_a? Secretary
      cannot :read, Admin
      cannot :update, Admin
      can :read, Dump
      can :create, Professor
      can :read, Professor
      can :update, Professor
      can :destroy, Professor
      can :create, Secretary
      can :read, Secretary
      can :update, Secretary
      can :change_password, Secretary #, :id => user.id #Only himself
      can :destroy, Secretary
      cannot :create, Student
      can :read, Student
      cannot :update, Student
      can :destroy, Student
      can :create, Course
      can :read, Course
      can :update, Course
      can :destroy, Course
      can :create, RequestForTeachingAssistant
      can :read, RequestForTeachingAssistant
      can :update, RequestForTeachingAssistant
      can :destroy, RequestForTeachingAssistant
      can :index_for_semester, RequestForTeachingAssistant
      can :create, Candidature
      can :read, Candidature
      can :update, Candidature
      can :destroy, Candidature
      #can :pay_assistant_frequency_for_month, AssistantFrequency

    elsif user.is_a? User and user.student?
      cannot :read, Admin
      cannot :update, Admin
      cannot :read, Dump
      cannot :create, Professor
      can :read, Professor
      cannot :update, Professor
      cannot :destroy, Professor
      cannot :create, Secretary
      can :read, Secretary
      cannot :update, Secretary
      cannot :destroy, Secretary
      cannot :create, Student
      can :read, Student #, :id => user.id #Only himself
      can :update, Student #, :id => user.id #Only himself
      can :destroy, Student #, :id => user.id #Only himself
      cannot :create, Course
      can :read, Course
      cannot :update, Course
      cannot :destroy, Course
      cannot :create, RequestForTeachingAssistant
      cannot :read, RequestForTeachingAssistant
      cannot :update, RequestForTeachingAssistant
      cannot :destroy, RequestForTeachingAssistant
      can :create, Candidature
      can :read, Candidature #, :student_id => user.id #Only his own
      can :update, Candidature #, :student_id => user.id #Only his own
      can :destroy, Candidature #, :student_id => user.id #Only his own
      can :update, AssistantRole
    else # 'ghost' User (usuario que não completou cadastro)
      cannot :read, Admin
      cannot :update, Admin
      cannot :read, Dump
      cannot :create, Professor
      cannot :read, Professor
      cannot :update, Professor
      cannot :destroy, Professor
      cannot :create, Secretary
      cannot :read, Secretary
      cannot :update, Secretary
      cannot :destroy, Secretary
      cannot :create, Student
      cannot :read, Student
      cannot :update, Student
      cannot :destroy, Student
      cannot :create, Course
      cannot :read, Course
      cannot :update, Course
      cannot :destroy, Course
      cannot :create, RequestForTeachingAssistant
      cannot :read, RequestForTeachingAssistant
      cannot :update, RequestForTeachingAssistant
      cannot :destroy, RequestForTeachingAssistant
      cannot :create, Candidature
      cannot :read, Candidature
      cannot :update, Candidature
      cannot :destroy, Candidature
      cannot :read, User
      cannot :update, User
      cannot :destroy, User
    end

    if user.is_a? User
      can :create, Student
    end

    # Standard user permissions
    if user.is_a? Admin or user.is_a? Secretary or (user.is_a? User and user.super_professor?)
      can :index, User
    end
    if user.is_a? User or user.is_a? Admin or user.is_a? Secretary
      can :show, User
      can :update, User
    end
    if user.is_a? Admin or user.is_a? Secretary
      can :destroy, User
    end

    # Semester management permissions
    if user.is_a? Admin or user.is_a? Secretary
      can :manage, Semester
    end

    # Candidature management permissions
    if user.is_a? Admin or user.is_a? Secretary or (user.is_a? User and user.super_professor?)
      can :index_for_department, Candidature
    elsif user.is_a? User and user.student?
      can :index_for_student, Candidature
    end

    # Assistant role management permissions
    if user.is_a? Admin or user.is_a? Secretary or (user.is_a? User and user.super_professor?)
      can :index, AssistantRole
    end
    if user.is_a? Admin or user.is_a? Secretary
      can :certificate, AssistantRole
    end
    if user.is_a? Secretary
      can :notify_for_semester, AssistantRole
      can :request_evaluations_for_semester, AssistantRole
      can :print_report, AssistantRole
      can :pay_all_assistants, AssistantFrequency
      can :open_frequency_period, AssistantFrequency
      can :close_frequency_period, AssistantFrequency
    end
    if user.is_a? Secretary or (user.is_a? User and user.super_professor?)
      can :create, AssistantRole
      can :update, AssistantRole
      can :destroy, AssistantRole
      can :monthly_control, AssistantFrequency
      can :deactivate_assistant_role, AssistantRole
      can :mark_generic_assistant_role_frequency, AssistantFrequency
      can :update, AssistantFrequency
      can :create, AssistantFrequency
      can :read, AssistantFrequency
    end
    if user.is_a? User and user.professor?
      can :index_for_professor, AssistantRole
      can :mark_assistant_role_frequency, AssistantFrequency
      if user.super_professor?
        can :mark_generic_assistant_role_frequency, AssistantFrequency
      end
    end

    if user.is_a? User and user.student?
      can :report_form, AssistantRole
      can :print_report, AssistantRole
    end

    # Assistant evaluation management permissions
    if user.is_a? User and user.professor?
      can :new, AssistantEvaluation
      can :edit, AssistantEvaluation
      can :create, AssistantEvaluation
      can :update, AssistantEvaluation
    end
    if user.is_a? Admin or user.is_a? Secretary or (user.is_a? User and user.super_professor?)
      can :index_for_student, AssistantEvaluation
    end

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
