pivotal_workstation_defaults "Automatically quit printer app once the print jobs complete" do
  domain 'com.apple.print.PrintingPrefs'
  key 'Quit When Finished'
  boolean true
end
