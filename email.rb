require 'date'

class Email
    attr_accessor :subject, :from, :date, :message, :to
    @@emails = []

    def initialize(raw)
        lines = raw.split("\n")
        @subject = /Subject:\s?((Re:|Fwd:)\s?)*/.match(lines[0]).post_match
        @from = lines[1][6...-1]
        @date = DateTime.parse(/Date:\s?/.match(lines[2]).post_match)
        @to = lines[3][4...-1]
        line1 = 3
        line1 += 1 while not lines[line1] =~ /\s/
        x, @message = line1+1, []
        while x < lines.size and lines[x][0] != '>' do 
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
