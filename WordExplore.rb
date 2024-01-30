# Program to explore text by word types.
# James Skon, Kenyon College
# January 2024

# Read file and break into lines
def getFileLines(name)
    fileObj = File.open(name)
    text=fileObj.read()
    text.split("\n")
end

# Read file and break into words, remove special character, downcase
def getFile(name)
    fileObj = File.open(name)
    text=fileObj.read()
    text=text.split(" ").map {|w| w.gsub(/\W/, '').downcase}
end

# Read in Conjugated verbs in hash where each verb for points to present tense version
def readVerbs
    fileObj = File.open("verbsConjugated.txt")
    lines=fileObj.read().split("\n")
    verbs = {}
    lines.each do |line|
        c=0
        pres=""
        line.split(",").each do |w|
            if c==0
                pres=w
            end
            verbs[w]=pres
            c+=1
        end
    end
    verbs
end

# Create count table of text count hash counting words from whitelist 
def createCountTableFilteredSimple(words,whitelist) 
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

def createCountVerbs(verbHash,words)
    verbCount = {}
    words.each do |w|
        if verbHash.include?(w)
            #puts "#{w}, #{verbHash[w]}, #{verbCount[w]}, #{verbCount[verbHash[w]]}"
            if !verbCount.include?(verbHash[w])
                puts "#{verbHash[w]} not in  verbCount"
                verbCount[verbHash[w]]=0
            end
            if verbCount.include?(w)
                print "<"
                verbCount[verbHash[w]]+=1
            else
                print ">"
                verbCount[verbHash[w]]=1
            end
        end
    end
    verbCount.sort_by {|key,value| value}
end

def displayTable(aHash)
    aHash.each do |key,value|
        print "#{key}: #{value}\n"
    end
end

#words = getFile("adjectives.txt")
text = getFile("emilydickenson.txt")

#countTable=createCountTableFilteredShort(text,words)
#displayTable(countTable)

verbHash = readVerbs()
#displayTable(verbHash)
verbCount=createCountVerbs(verbHash,text)
displayTable(verbCount)