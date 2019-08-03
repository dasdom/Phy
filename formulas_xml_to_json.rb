require 'plist'
require 'pp'

def formula_from_hash(raw_hash)
    title = raw_hash['Title']
    formula = {'title' => title, 'imageName' => raw_hash[title]}
end

xmlFile = ARGV[0]

result = Plist.parse_xml(xmlFile)

mechanics_dict = result['Rows'].first.first

puts mechanics_dict.count

mechanics_dict.each { |key, value| 
    puts key
}

special_field_sections = []
special_fields = []

mechanics_dict['Child'].first.each { |b|
    formula_sections = []
    title = b['Title']
    
    section_titles = b['namesOfSections']
    formulas_without_section = []
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

        puts section_title

        formula_sections << {'title' => section_title, 'formulas' => formulas}
    }
    
    if formulas_without_section.count > 0
        formula_sections << {'title' => 'None', 'formulas' => formulas_without_section}
        formulas_without_section = []
    end

    special_fields << {'title' => title, 'formulaSections' => formula_sections}
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

pp special_fields

special_field_sections.append(special_fields)
#}

