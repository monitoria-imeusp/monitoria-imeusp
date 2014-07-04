class Ability
  include CanCan::Ability

  def initialize(user)
    if nil == defined? user #user is not logged in
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
    elsif user.is_a? Professor and user.professor_rank == 2 #SSProfessor
      can :create, Professor
      can :read, Professor
      can :update, Professor
      can :destroy, Professor
      cannot :create, Secretary
      can :read, Secretary
      cannot :update, Secretary
      cannot :destroy, Secretary
      cannot :create, Student
      can :read, Student
      cannot :update, Student
      cannot :destroy, Student
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
    elsif user.is_a? Professor and user.professor_rank == 1 #SProfessor
      can :create, Professor
      can :read, Professor
      can :update, Professor
      can :destroy, Professor
      cannot :create, Secretary
      can :read, Secretary
      cannot :update, Secretary
      cannot :destroy, Secretary
      cannot :create, Student
      can :read, Student
      cannot :update, Student
      cannot :destroy, Student
      can :create, Course
      can :read, Course
      can :update, Course
      can :destroy, Course
      can :create, RequestForTeachingAssistant
      can :read, RequestForTeachingAssistant #Only his Dept.
      can :update, RequestForTeachingAssistant #Only his Dept.
      can :destroy, RequestForTeachingAssistant #Only his Dept.
      can :create, Candidature
      can :read, Candidature
      can :update, Candidature
      can :destroy, Candidature
    elsif user.is_a? Professor and user.professor_rank == 0 #Professor
      cannot :create, Professor
      can :read, Professor
      can :update, Professor #Only himself
      can :destroy, Professor #Only himself
      cannot :create, Secretary
      can :read, Secretary
      cannot :update, Secretary
      cannot :destroy, Secretary
      cannot :create, Student
      can :read, Student
      cannot :update, Student
      cannot :destroy, Student
      cannot :create, Course
      can :read, Course
      cannot :update, Course
      cannot :destroy, Course
      can :create, RequestForTeachingAssistant
      can :read, RequestForTeachingAssistant #Only his own
      can :update, RequestForTeachingAssistant #Only his own
      can :destroy, RequestForTeachingAssistant #Only his own
      cannot :create, Candidature
      cannot :read, Candidature
      cannot :update, Candidature
      cannot :destroy, Candidature
    elsif user.is_a? Secretary
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
      cannot :create, Professor
      can :read, Professor
      cannot :update, Professor
      cannot :destroy, Professor
      cannot :create, Secretary
      can :read, Secretary
      cannot :update, Secretary
      cannot :destroy, Secretary
      cannot :create, Student
      can :read, Student
      can :update, Student #Only himself
      can :destroy, Student #Only himself
      can :create, Course #Only himself
      can :read, Course
      cannot :update, Course
      cannot :destroy, Course
      cannot :create, RequestForTeachingAssistant
      can :read, RequestForTeachingAssistant
      cannot :update, RequestForTeachingAssistant
      cannot :destroy, RequestForTeachingAssistant
      can :create, Candidature
      can :read, Candidature #Only his own
      can :update, Candidature #Only his own
      can :destroy, Candidature #Only his own
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
