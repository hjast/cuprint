#!/usr/bin/ruby
#Reuben Doetsch
#Will work on 10.6
require 'yaml'

module CuPrint

  OPTION_MENU = "1.) Add printer\n 2.) Add all printers\n 3.) Quit ";
  Struct.new("Printer", :name, :place,:address, :driver) 

  def run
    printersArray = YAML.load_file(File.join(File.dirname(__FILE__), 'printers.yaml'))["printers"]
    printers= Array.new
    printersArray.each { |printerHash| printers << Struct::Printer.new(printerHash["name"], printerHash["place"],printerHash["address"], printerHash["driver"])  }
  
    exit = false
    while(!exit)
     puts OPTION_MENU 
     case gets.to_i
       when 1
         puts "Printers" 
         printers.each_index { |x|  puts x.to_s + ".)" + printers[x]["name"] }
         add_printer(printers[gets.to_i])
       when 2
         printers.each { |x| add_printer(x) }
       when 3
         exit= true
      end
    end

  end

  def add_printer(print)
    driver = case print["driver"]
    when "HP LaserJet 9050" ;  "/Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9050.gz"
    when "HP LaserJet 4350" ; "  /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 4350.gz"
    end
    puts driver
    `lpadmin -p #{print["n  ame"]} -L #{print["place"]} -E -v lpd://#{print["address"]}/public -P #{driver} `
  end
  #{}`lpadmin -p "mudd" -L "Mudd Library" -E -v lpd://mudd251a-ninja.atg.columbia.edu -P /Library/Printers/PPDs/Contents/Resources/HP\ LaserJet\ 9050.gz` 


end