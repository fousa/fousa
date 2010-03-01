class FousaMailer < ActionMailer::Base

  def contact(contact)
    recipients  "jelle@fousa.be"
    from        "#{contact.name} <#{contact.email}>"
    subject     "Fousa :: Message from #{contact.name}"
    body        :contact => contact
  end

  def comment(comment)
    recipients  "jelle@fousa.be"
    from        "Fousa Commenting System <jelle@fousa.be>"
    subject     "Fousa :: comment from #{comment.name}"
    body        :comment => comment
  end

end