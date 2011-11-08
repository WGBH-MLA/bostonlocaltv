class Dataset::Nhf < Dataset::Xml
  def content
    s = super
    s.gsub!(/(<\/?[A-Za-z0-9_]+):/) { $1 } 
    s.gsub!('_#>', '_num>')
    s.gsub!('<#', '<num')
    s.gsub!('</#', '</num')
    s
  end

  protected
  def process_record(row, solr_doc = {})
    super(row, solr_doc)

    solr_doc[:id] = solr_doc[:'accession_num_s'].try(:first).try(:parameterize)
    solr_doc[:collection_s] = 'NHF'

    solr_doc
  end

end
