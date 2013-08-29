require 'sinatra'

module LastN  # create module 
    def last(n) # funtion to get last character of line
        self[-n,n]
    end
end

class String #open String class
    include LastN #include the module in the string class
end

def boldify(line)
    line = '<b>' + line + '</b>'
    return line
end

def clear(line)
    line = "<br>"
    return line
end

get '/' do
    erb :index
end

post '/' do
    @input_text = params[:input_text] # read input from user
    counter = 1 
    @input_text.each_line do |line|
        line = line.strip #strip whitespace and newline
        if counter == 1
            line = '<b>' + line + '</b><br>' unless line.end_with?('.') # wrap line in bold tags if line does not end with '.'
        else
            line = '<br><br><b>' + line + '</b><br>' unless line.end_with?('.')
        end
        line = " " if line == "<br><br><b></b><br>" #remove bold tags, if the line is empty before entered
        counter += 1
        line = " " if line == "<b></b>" #remove bold tags, if the line is empty before entered
        @output_text ||= "" #set output to an empty string if it has not been set
        @output_text = @output_text + line # add line to string and return it
    end
    @output_text.strip! 
    erb :index
end
