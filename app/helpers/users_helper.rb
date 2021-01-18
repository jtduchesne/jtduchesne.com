module UsersHelper
  def emphasis_if_unverified(user, attr)
    if user.verified?
      tag.span user.send(attr)
    else
      tag.em user.send(attr)+"*".freeze, title: User.human_attribute_name(:unverified)
    end
  end
end
