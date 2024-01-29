# Program to explore text by word types.
# James Skon, Kenyon College
# January 2024

# Read file and break into words
def getFile(name)
    fileObj = File.open(name)
    text=fileObj.read()
    text=text.split(" ").map {|w| w.gsub(/\W/, '').downcase}
end


# Create count table of text count hash counting words from whitelist 
def createCountTableFilteredSimple(text,whitelist) 
    table = {}
    text.each do |line|
        words = line.split(" ")
        words.each do |word|
            puts word
            #word=word.gsub(/\W/, '').downcase.chomp
            if whitelist.include?(word)
                if table.include?(word)
                    table[word]+=1
                else
                    table[word]=1
                end
            end
        end
    end
    table.sort_by {|key,value| value}    
end

# Create count table of text count hash counting words from whitelist 
def createCountTableFilteredShort(text,whitelist) 
    table = {}
    words=text.select { |w| whitelist.include?(w)}
    words.each do |w|
        if table.include?(w)
            table[w]+=1
        else
            table[w]=1
        end
    end
    table.sort_by {|key,value| value}    
end

def displayTable(aHash)

    aHash.each do |key,value|
        print "#{key}: #{value}\n"
    end
end

words = getFile("adjectives.txt")
text = getFile("emilydickenson.txt")

countTable=createCountTableFilteredShort(text,words)

displayTable(countTable)