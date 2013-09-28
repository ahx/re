class ReceiptMailer < ActionMailer::Base
  default from: "noreply@re.de.a9sapp.eu"

  def read_confirmation(tracker, view)
    @tracker = tracker
    @view = view
    subject = %(Deine E-Mail "#{tracker.subject}" wurde geöffnet)
    mail(to: tracker.sender, subject: subject)
  end
end
