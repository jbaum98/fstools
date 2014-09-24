require 'date'

class Email
    attr_accessor :subject, :from, :date, :message, :to
    @@emails = []

    def initialize(raw)
        lines = raw.split("\n")
        @subject = /Subject:\s?((Re:|Fwd:)\s?)*/.match(lines[0]).post_match
        @from = /From:\s?(.*?)\s?<.*>/.match(lines[1]).captures[0]
        @date = DateTime.parse(/Date:\s?/.match(lines[2]).post_match)
        @to = /To:\s?(.*?)\s?<.*>/.match(lines[3]).captures[0]
        x, @message = 5, []
        while lines[x][0] != '>' do 
            @message.push lines[x]
            x+=1
        end
        @message = @message[0...-1].join("\n")
        @@emails.push self
    end

    def self.emails
        return @@emails
    end
end