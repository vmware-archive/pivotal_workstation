pivotal_workstation_defaults "Save to disk (not to iCloud) by default" do
  domain 'NSGlobalDomain'
  key 'NSDocumentSaveNewDocumentsToCloud'
  boolean false
end
