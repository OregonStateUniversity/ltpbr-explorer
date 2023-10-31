class User < ApplicationRecord

  attr_accessor :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects, foreign_key: 'author_id', inverse_of: :author

  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates :name, presence: true
  validates :affiliation, presence: true
  validates :role, presence: true

  enum role: { public: 'public', admin: 'admin' }, _suffix: true

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        conditions[:email].downcase! if conditions[:email]
        where(username: conditions[:username]).first
      end
    end
  end

end
