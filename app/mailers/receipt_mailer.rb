class ReceiptMailer < ActionMailer::Base
  default from: "from@example.com"

  def read_confirmation(tracker, view)
    @tracker = tracker
    @view = view
    subject = %(Deine E-Mail "#{tracker.subject}" wurde geöffnet)
    mail(to: tracker.sender, subject: subject)
  end
end
