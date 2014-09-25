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

    opts.on('-o', '--out out', 'Output file') do |out|
        options[:out] = out
    end
end

parser.parse!

def is_letter?(chr)
    return (chr =~ /[A-Za-z]/) != nil
end

def decode(chr)
    downs = 'abcdefghijklmnopqrstuvwxyz'
    ups = downs.upcase
    if downs.include? chr.downcase
        index = downs.index chr.downcase
        new_index = (index + 14)%downs.size
        if downs.include? chr
            return downs[new_index]
        else 
            return ups[new_index]
        end
    else
        return chr
    end
end

def decode_line(line)
    return line.split('').map {|chr| decode(chr)}.join()
end

def decode_file(file, out='')
    if file.is_a? String
        out << decode_line(file)
    elsif file.is_a? File
       file.each_line { |line| out << decode_line(line) } 

    end
    return out if out.is_a? String
end

ARGV.each do |file|
    unless options[:out].nil?
        out = File.open options[:out], 'a'
    else
        out = File.open(options[:prefix] + file, 'w')
    end
    File.open(file, 'r') { |f| decode_file(f, out) }
    out.close()
end
