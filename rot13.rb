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
p ARGV[0]
out_name = File.basename(ARGV[0], File.extname(ARGV[0])) + '_decrypt' + File.extname(ARGV[0])
out = File.open(out_name, 'a')
File.open(ARGV[0], 'r') do |file|
    file.each_line do |line|
        chars = line.split('')
        oline = ''
        chars.each do |char|
            if is_letter?(char)
                oline += encode char
            else
                oline += char
            end
        end
        out.write(oline)
    end
end
out.close()