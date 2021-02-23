# frozen_string_literal: true

namespace :import do
  desc 'Импорт xml c http://opencorpora.org/dict.php - spring rake import:xml\[/Users/dog/Downloads/dict.opcorpora.xml\]'
  task :xml, [:file] => :environment do |_t, args|
    puts 'Import xml'
    if args[:file].present?
      ImportReader.call args[:file], log: true
    else
      ImportReader.call log: true
    end
    puts "Xml imported"
  end
end
