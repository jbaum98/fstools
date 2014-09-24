#!/usr/bin/ruby

require 'optparse' 

options = {
    prefix: 'decode_',
    out: nil
}
parser = OptionParser.new do |opts|
    opts.banner = "Usage: rot.rb [file] [options]"

    opts.on('-p', '--prefix prefix', 'Prefix') do |prefix|
        options[:prefix] = prefix
    end

    opts.on('-o', '--out out', 'Output file') do |prefix|
        options[:out] = out
    end
end

parser.parse!

def is_letter?(chr)
    return (chr =~ /[A-Za-z]/) != nil
end

def encode(chr)
    downs = 'abcdefghijklmnopqrstuvwxyz'
    ups = downs.upcase
    index = downs.index chr.downcase
    new_index = (index + 14)%downs.size
    if downs.include? chr
        return downs[new_index]
    else 
        return ups[new_index]
    end
end

def encode_line(line)
    return line.each_char do |chr|
        is_letter?(chr) ? encode(chr) : chr
    end
end

Dir.chdir File.dirname(ARGV[0])
files =  Dir.glob File.basename(ARGV[0])
files.each do |file|
    unless options[:out].nil?
        out = File.open options[:out], 'a'
    else
        out = File.open(options[:prefix] + file, 'w')
    end
    File.open(file, 'r') do |f|
        f.each_line do |line|
            out.write(encode_line(line))
        end
    end
    out.close()
end
