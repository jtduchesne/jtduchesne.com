module MessagesHelper
  def options_for_subject(message)
    options_for_select(Message.subjects.transform_keys{|k| t(".subject.#{k}") }, message.subject)
  end
end
