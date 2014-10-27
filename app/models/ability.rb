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
      can :create, Student
      cannot :read, Student
      cannot :update, Student
      cannot :destroy, Student
      cannot :create, Course
      can :read, Course
      cannot :update, Course
      cannot :destroy, Course
      cannot :create, RequestForTeachingAssistant
      can :read, RequestForTeachingAssistant
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
      can :update, Professor
      can :destroy, Professor
      can :create, Secretary
      can :read, Secretary
      can :update, Secretary
      can :destroy, Secretary
      cannot :create, Student
      can :read, Student
      can :update, Student
      can :destroy, Student
      can :create, Course
      can :read, Course
      can :update, Course
      can :destroy, Course
      can :create, RequestForTeachingAssistant
      can :read, RequestForTeachingAssistant
      can :update, RequestForTeachingAssistant
      can :destroy, RequestForTeachingAssistant
      can :create, Candidature
      can :read, Candidature
      can :update, Candidature
      can :destroy, Candidature
    elsif user.is_a? Professor #Professor
      cannot :read, Admin
      cannot :update, Admin
      can :read, Professor
      can :update, Professor #, :id => user.id #Only himself
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
      if user.professor_rank > 0
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
      can :create, Candidature
      can :read, Candidature
      can :update, Candidature
      can :destroy, Candidature
    elsif user.is_a? Student
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
      can :read, RequestForTeachingAssistant
      cannot :update, RequestForTeachingAssistant
      cannot :destroy, RequestForTeachingAssistant
      can :create, Candidature
      can :read, Candidature #, :student_id => user.id #Only his own
      can :update, Candidature #, :student_id => user.id #Only his own
      can :destroy, Candidature #, :student_id => user.id #Only his own
    end

    # Semester management permissions
    if user.is_a? Admin or user.is_a? Secretary
      can :manage, Semester
    end

    # Candidature management permissions
    if user.is_a? Admin or user.is_a? Secretary or (user.is_a? Professor and user.professor_rank > 0)
      can :index_for_department, Candidature
    elsif user.is_a? Student
      can :index_for_student, Candidature
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
