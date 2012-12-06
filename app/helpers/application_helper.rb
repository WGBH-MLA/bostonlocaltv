module ApplicationHelper
    require 'open-uri'
    require 'pp'

   def setup_vote(vote)
     vote = Vote.new
   end
        
   def export_as_chicago_citation_txt (document)
    text = ''

    title = setup_title_info (document[:title_t])
    if !title.nil?
      text += "&ldquo;" + mla_citation_title(title) + "&rdquo; "
    end
    text += ", "

    text += setup_pub_date unless setup_pub_date.nil?
    if text[-1,1] != "."
      text += ", " unless text.nil? or text.blank?
    end
   
    series_text = setup_series_info(document[:title_t])
    s_text = series_text.join

    text += s_text + ", " unless s_text.nil?

    text += "WGBH Media Library &amp; Archives, "

    text += "(accessed " + Date.current.strftime("%d %b %Y") + ")"

    text.html_safe

  end



  def export_as_mla_citation_txt (document)
    text = ''
    # setup title
    title = setup_title_info (document[:title_t])
    if !title.nil?
      text += "&ldquo;" + mla_citation_title(title) + "&rdquo; "
    end
    # Edition
    edition_data = setup_edition
    text += edition_data + " " unless edition_data.nil?

    # Get Pub Date
    text += setup_pub_date unless setup_pub_date.nil?
    if text[-1,1] != "."
      text += ". " unless text.nil? or text.blank?
    end

    # Publication
    series_text = setup_series_info(document[:title_t])
    s_text = series_text.join
    text += s_text + ", " unless s_text.nil?

    text += "WGBH Media Library &amp; Archives, "

    text += "Web. "

    text += Date.current.strftime("%d %b %Y") + "."

    text.html_safe
    
  end

  def export_as_apa_citation_txt (document)
    text = ''

    # setup title info
    title = setup_title_info (document[:title_t])
    text += title +" " unless title.nil?

    # Get Pub Date
    text += "(" + setup_pub_date + "). " unless setup_pub_date.nil?


    # Edition
    edition_data = setup_edition
    text += edition_data + " " unless edition_data.nil?

    # Publisher info
    text += "Boston, MA: WGBH Media Library &amp; Archives. "

    text += "Retrieved " + Date.current.strftime("%d %b %Y") + ""

    text.html_safe
  end

  def setup_title_info (title)
     text = title.join
    return nil if text.try(:strip).blank?
    clean_end_punctuation(text.strip) + "."
  end

  
  def mla_citation_title(text)
    no_upcase = ["a","an","and","but","by","for","it","of","the","to","with"]
    new_text = []
    word_parts = text.split(" ")
    word_parts.each do |w|
      if !no_upcase.include? w
        new_text.push(w.capitalize)
      else
        new_text.push(w)
      end
    end
    new_text.join(" ")
  end

  def clean_end_punctuation(text)
    if [".",",",":",";","/"].include? text[-1,1]
      return text[0,text.length-1]
    end
    text
 end

  def setup_pub_date
    date_value = self.get('dc_date_s') rescue ''
    date_value
  end

  def setup_pub_info
    text = self.get('dc_publisher_s')
    text ||= 'WGBH Media Library &amp; Archives'
    clean_end_punctuation(text.strip)
  end

  def setup_series_info (pbcoreTitle)
    pbcoreTitle
  end

  def setup_edition
      return nil
  end
 
  def get_wcvb_doc (doc_id)
    @document
  end


  def widont(text)
    text.gsub(/([^\s])\s+([^\s]+)\s*$/, '\1&nbsp;\2')
  end

  def render_wordpress_page_content slug
    Wordpress::Page.find(slug).content.html_safe # rescue nil
  end

  def render_google_analytics_code
    render :partial => 'layouts/google_analytics', :locals => { :tracker_id => GOOGLE_ANALYTICS_TRACKER_ID } if defined?(GOOGLE_ANALYTICS_TRACKER_ID)
  end

  def render_votes_visits_code
    render :partial => 'layouts/votes_visits'
  end

  def render_comment_metadata_information comment
    if comment.metadata[:begin] && comment.metadata[:end] && comment.metadata[:begin] != comment.metadata[:end]
      return "[Timecode #{comment.metadata[:begin]}-#{comment.metadata[:end]}]"
    end

    if comment.metadata[:begin]
      return "[Timecode #{comment.metadata[:begin]}]"
    end

    if comment.metadata[:crop]
      return "[Crop]"
    end
  end


  def get_blog_page
  
      results = []

      open ('http://bostonlocaltv.org') do |f|
        f.each_line {|line| results << line}
      end

      results
  end

end
