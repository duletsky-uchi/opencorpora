# frozen_string_literal: true

namespace :import do
  desc 'Импорт xml c http://opencorpora.org/dict.php'
  task :xml, [:file] => :environment do |_t, args|
    puts 'Import xml'
    if args[:file].present?
      Import.call args[:file]
    else
      Import.call
    end
    puts "Xml imported"
  end
end
