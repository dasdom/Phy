require 'plist'
require 'pp'
require 'json'

def formula_from_hash(raw_hash)
    title = raw_hash['Title']
    formula = {:title => title, :imageName => raw_hash[title][0...-4]}

    child = raw_hash['Child']
    unless child.nil?
        detail_sections = []
        namesOfSections = raw_hash['namesOfSections']
        child.each_with_index { |a, index|
            rows = []
            #puts "a: #{a}"
            if a.class == Array
                a.each { |b|
                    #puts "b: #{b}"
                    title = b['Title']
                    row = {:imageName => b[title][0...-4]}
                    row[:title] = title
                    rows << row
                }
            else
                title = a['Title']
                row = {:imageName => a[title][0...-4]}
                row[:title] = title
                rows << row
            end
            if namesOfSections.nil? || namesOfSections.count < 1
                detail_sections << {:title => 'None', :detailItems => rows}
            else
                detail_sections << {:title => namesOfSections[index], :detailItems => rows}
            end
        }
        formula['details'] = detail_sections
    end

    return formula
end

xmlFile = ARGV[0]

result = Plist.parse_xml(xmlFile)

topic_dict = result['Rows'][2].first

puts topic_dict.count

topic_dict.each { |key, value| 
    puts "key: #{key}"
}

special_field_sections = []

isChem = false

topic_dict['Child'].each { |sfs|
    special_fields = []
    sfs.each { |b|
        formula_sections = []
        puts b
        title = b['Title']
        
        section_titles = b['namesOfSections']
        formulas_without_section = []

        child = b['Child']

        if child.nil?
            special_fields << b
            isChem = true
        else
            b['Child'].each_with_index { |c, index|
                
                formula_title = ""
                
                formulas = []

                if c.class == Array
                    c.each { |d|
                        formulas << formula_from_hash(d)
                    }
                else
                    formulas_without_section << formula_from_hash(c)
                    next
                end
                section_title = ""
                
                if section_titles.nil? || section_titles.count < 2
                    section_title = 'None'
                else
                    section_title = section_titles[index]
                end

                puts "section title: #{section_title}"

                formula_sections << {:title => section_title, :formulas => formulas}
            }
        
            if formulas_without_section.count > 0
                formula_sections << {:title => 'None', :formulas => formulas_without_section}
                formulas_without_section = []
            end
        end

        if formula_sections.count > 0
            special_fields << {:title => title, :formulaSections => formula_sections}
        end
    }

    if isChem
        special_field_sections = special_fields
    else
        special_field_sections << {:title => 'None', :specialFields => special_fields}
    end
}

puts '-------------------------------------------'

#special_fields.each { |sf|
#    puts sf['title']
#    sf['formulaSections'].each { |section|
#        puts "\t#{section['title']}"
#        section['formulas'].each { |formula|
#            puts "\t\t#{formula}"
#        }
#    }
#}

pp special_field_sections

json = JSON.pretty_generate(special_field_sections)

File.open('data_automatic.json', 'w') { |file| file.write(json) }

#}

