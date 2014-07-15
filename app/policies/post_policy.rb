class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def destroy?
#    user.present? && (record.user == user || user.role?(:admin) || user.role?(:moderator))
    user.present? && can_moderate?(user, record)
  end
end
