class DashboardController < ApplicationController
  def index
    @news = get_news
    @deadlines = current_user.deadlines.includes(:user)
  end

  private

  def get_news
    begin
      rss = RSS::Parser.parse(open("http://www.lawinside.ch/feed/").read, false).items[0..10]
      feed = []
      
      rss.each do |item|
        article = {
          title: item.title,
          pubdate: item.pubDate,
          author: item.dc_creator,
          link: item.link,
          content: item.description
        }
        feed.push(article)
      end

      return feed
    rescue SocketError => e
      return e
    end
  end
end
