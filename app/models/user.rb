class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :authentication_keys => [:nusp], :omniauth_providers => [:usp]

  include ActiveModel::Validations
  #include Devise::Controllers::Helpers

  validates :name , presence: true
  validates :nusp , presence: true, inclusion: { in: 0..100000000 }, uniqueness: true
  validates :email , presence: true
  has_one :student
  has_one :professor

  def student
    result = Student.where(user_id: id)
    if block_given? and result.any?
      yield result.take
    else
      result.take
    end
  end

  def student?
    Student.where(user_id: id).any?
  end

  def professor
    result = Professor.where(user_id: id)
    if block_given? and result.any?
      yield result.take
    else
      result.take
    end
  end

  def professor?
    Professor.where(user_id: id).any?
  end

  def super_professor?
    query = Professor.where(user_id: id)
    query.any? and query.take.super_professor?
  end

  def hiper_professor?
    query = Professor.where(user_id: id)
    query.any? and query.take.hiper_professor?
  end

  def should_see_role role
    professor do |prof|
      if prof.super_professor? and role.course.dep_code == prof.dep_code
        # Membros da comissão de monitoria vêm monitores do seu departamento inteiro
        return true
      elsif role.request_for_teaching_assistant.professor == prof
        # Professores normais vêem apenas seus próprios monitores
        return true
      end
    end
    return false
  end

  def self.from_omniauth auth
    registered = where nusp: auth.info.nusp
    if registered.any?
      user = registered.take
      if auth.info.link == :student or auth.info.link == :teacher
        user.name = auth.info.name
        user.email = auth.info.email
        user.provider = auth.provider
        user.uid = auth.uid
        user.save
      end
      user
    else
      user = User.new(nusp: auth.info.nusp, name: auth.info.name, email: auth.info.email, password: "changeme!")
      user.confirmed_at = Time.now
      user.skip_confirmation_notification!
      unless user.save
        raise user.errors.inspect
      end
      if auth.info.link == :teacher 
        prof = Professor.new(user_id: user.id, department: Department.find_by(:code => "MAC"), dirty: true)
        unless prof.save
          raise prof.errors.inspect
        end
      end
      user
    end
  end
 
 end
