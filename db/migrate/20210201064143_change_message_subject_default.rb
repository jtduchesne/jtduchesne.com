class ChangeMessageSubjectDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :messages, :subject, "message"
    Message.where.not(subject: Message.subjects.keys).in_batches.update_all(message: "message")
  end
end
