class DashboardController < ApplicationController

  def index
    @news = get_news
    @deadlines = current_user.deadlines.includes(:assignee)
  end

  private

  def get_news
    feed = []
    rss = RSS::Parser.parse(open("http://www.lawinside.ch/feed/").read, false).items[0..10]

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
  end
end
