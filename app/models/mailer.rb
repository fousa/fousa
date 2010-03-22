class Mailer < ActionMailer::Base

  default :to => "jelle@fousa.be"

  def contact_notifier(contact)
    @contact = contact

    mail :from =>    "#{contact.name} <#{contact.email}>",
         :subject => "Fousa :: Contact message from #{contact.name}"
  end

  def comment_notifier(comment)
    @comment = comment

    mail :bcc     => comment.post.comments.map(&:email).uniq.select { |email| email != @comment.email }.join(", "),
         :from    => "Fousa Commenting System <jelle@fousa.be>",
         :subject => "Fousa :: Comment from #{comment.name}"
  end

end