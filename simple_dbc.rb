require "../dbc/dbc_jar/dbc.jar"
require "../dbc/dbc_jar/commons-daemon.jar"
require "../dbc/dbc_jar/mysql-connector-java-5.0.7-bin.jar"
require "java"

class SimpleDBC

  def initialize(host)
    @host = host
    @dbc = Java::de.uni_tuebingen.wsi.ct.slang2.dbc.client::DBC.new(@host)
  end

  def chapter(id)
    @dbc.load_chapter(id.to_i)
  end

  def books
    @dbc.load_books.to_a
  end

  def book(id)
    #load_book scheint nicht die verknüpfungen zu laden
    @dbc.load_books.select{|book| book.db_id == id.to_i}.first
  end

  def chapter_loader
    frame = javax.swing.JFrame.new("Window")
    loader = Java::de.uni_tuebingen.wsi.ct.slang2.dbc.tools.dialogs.chapterloader::ChapterLoader.new(@host)
    loader.show_dialog(frame)
    return self.chapter(loader.get_chapter_id)
  end

  def print_wordclass(word)

    @dbc.loadWordListElement(word.to_s).each {|x| puts x.get_assignation.get_wordclasses.map(&:to_s)}

  end

  def has_wordclass(word,wordclass)
    @dbc.loadWordListElement(word.to_s).inject(false) do |res,word_s|
      res or word_s.get_assignation.get_wordclasses.map(&:to_s).include?(wordclass)
    end
  end

  
end
